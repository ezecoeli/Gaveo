import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../dashboard/providers/dashboard_providers.dart';

part 'gastos_fijos_providers.g.dart';

// ── VencimientoProximo ────────────────────────────────────────────────────────

class VencimientoProximo {
  final GastosFijo gastoFijo;
  final int diasRestantes; // 0 = hoy, 1 = mañana, ...

  const VencimientoProximo({
    required this.gastoFijo,
    required this.diasRestantes,
  });
}

// ── Providers ─────────────────────────────────────────────────────────────────

@riverpod
Stream<List<GastoFijoConPago>> gastosFijosDelMes(
    // ignore: deprecated_member_use_from_same_package
    GastosFijosDelMesRef ref) {
  final db = ref.watch(appDatabaseProvider);
  final month = ref.watch(selectedMonthProvider);
  return db.gastosFijosDao.watchGastosFijosConPago(month.mes, month.anio);
}

/// Gastos fijos activos, con día de vencimiento, no pagados aún, que vencen
/// en los próximos [_kDiasVentana] días. Solo se computa para el mes actual;
/// para cualquier otro mes devuelve lista vacía.
const int _kDiasVentana = 7;

@riverpod
Future<List<VencimientoProximo>> proximosVencimientos(
    // ignore: deprecated_member_use_from_same_package
    ProximosVencimientosRef ref) async {
  final month = ref.watch(selectedMonthProvider);
  final now = DateTime.now();

  // Solo aplica al mes en curso
  if (month.mes != now.month || month.anio != now.year) return [];

  final gastos = await ref.watch(gastosFijosDelMesProvider.future);
  final today = DateTime(now.year, now.month, now.day);
  final daysInMonth = DateTime(month.anio, month.mes + 1, 0).day;

  final result = <VencimientoProximo>[];
  for (final g in gastos) {
    final dia = g.gastoFijo.diaVencimiento;
    if (dia == null || g.estaPagado) continue;

    final diaEfectivo = dia.clamp(1, daysInMonth);
    final fechaVencimiento = DateTime(month.anio, month.mes, diaEfectivo);
    final diff = fechaVencimiento.difference(today).inDays;

    if (diff >= 0 && diff <= _kDiasVentana) {
      result.add(VencimientoProximo(
        gastoFijo: g.gastoFijo,
        diasRestantes: diff,
      ));
    }
  }

  result.sort((a, b) => a.diasRestantes.compareTo(b.diasRestantes));
  return result;
}
