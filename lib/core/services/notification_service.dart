import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../core/database/app_database.dart';

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'gaveo_vencimientos';
  static const _channelName = 'Vencimientos';

  static Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings);
    await _requestPermissions();
  }

  static Future<void> _requestPermissions() async {
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    await ios?.requestPermissions(alert: true, badge: true, sound: true);

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
  }

  /// Cancela todas las notificaciones pendientes.
  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  /// Cancela todas las notificaciones pendientes y programa una notificación
  /// a las 9:00 AM para el día de vencimiento de cada gasto fijo activo.
  /// Si el día ya pasó este mes, programa para el mes siguiente.
  static Future<void> scheduleVencimientosMensuales(
    List<GastosFijo> gastosFijos, {
    String? title,
    String Function(String nombre)? bodyBuilder,
  }) async {
    await _plugin.cancelAll();

    final now = tz.TZDateTime.now(tz.local);

    for (final gasto in gastosFijos) {
      if (!gasto.activo || gasto.diaVencimiento == null) continue;

      // Clamp day to valid range for the current month
      final daysInCurrentMonth = DateTime(now.year, now.month + 1, 0).day;
      final dia = gasto.diaVencimiento!.clamp(1, daysInCurrentMonth);

      tz.TZDateTime scheduled = tz.TZDateTime(
        tz.local, now.year, now.month, dia, 9,
      );

      // If the due day already passed this month, schedule for next month
      if (scheduled.isBefore(now)) {
        final nextYear = now.month == 12 ? now.year + 1 : now.year;
        final nextMonth = now.month == 12 ? 1 : now.month + 1;
        final daysInNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;
        final diaNext = gasto.diaVencimiento!.clamp(1, daysInNextMonth);
        scheduled = tz.TZDateTime(tz.local, nextYear, nextMonth, diaNext, 9);
      }

      final body = bodyBuilder != null
          ? bodyBuilder(gasto.nombre)
          : '${gasto.nombre} vence hoy';

      await _plugin.zonedSchedule(
        gasto.id,
        title ?? 'Vencimiento',
        body,
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}

