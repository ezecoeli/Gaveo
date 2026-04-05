import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  /// Cancels all pending notifications and re-schedules one immediate
  /// notification for each gasto fijo whose due day is today.
  static Future<void> scheduleVencimientosHoy(
    List<GastosFijo> gastosFijos, {
    String Function(String nombre)? bodyBuilder,
  }) async {
    await _plugin.cancelAll();

    final today = DateTime.now().day;
    final vencenHoy = gastosFijos.where(
        (g) => g.activo && g.diaVencimiento != null && g.diaVencimiento == today);

    int notifId = 0;
    for (final gasto in vencenHoy) {
      final body = bodyBuilder != null
          ? bodyBuilder(gasto.nombre)
          : '${gasto.nombre} vence hoy';

      await _plugin.show(
        notifId++,
        'Vencimiento hoy',
        body,
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
      );
    }
  }
}

