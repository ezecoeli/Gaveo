import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/date_utils.dart';
import 'dashboard_summary.dart';

part 'dashboard_providers.g.dart';

// ── Mes seleccionado (estado global de sesión) ────────────────────────────────

@riverpod
class SelectedMonth extends _$SelectedMonth {
  @override
  ({int mes, int anio}) build() {
    final now = DateTime.now();
    return (mes: now.month, anio: now.year);
  }

  void goToPreviousMonth() {
    final prev = AppDateUtils.previousMonth(state.mes, state.anio);
    state = prev;
  }

  void goToNextMonth() {
    if (AppDateUtils.canGoToNextMonth(state.mes, state.anio)) {
      final next = AppDateUtils.nextMonth(state.mes, state.anio);
      state = next;
    }
  }

  void setMonth(int mes, int anio) {
    state = (mes: mes, anio: anio);
  }
}

// ── Dashboard summary ─────────────────────────────────────────────────────────

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardSummary> build() async {
    final monthState = ref.watch(selectedMonthProvider);
    final mes = monthState.mes;
    final anio = monthState.anio;

    final db = ref.watch(appDatabaseProvider);

    final ingresos = await db.ingresosDao.getIngresosDelMes(mes, anio);
    final gastosFijos = await db.gastosFijosDao.getGastosFijosActivos();
    final gastosVariables =
        await db.gastosVariablesDao.getGastosVariablesDelMes(mes, anio);
    final delivery = await db.deliveryDao.getDeliveryDelMes(mes, anio);
    final ahorros = await db.ahorrosDao.getAhorrosActivos();
    final presupuestoRaw = await db.configuracionDao
        .getValor(AppConstants.keyPresupuestoDelivery);

    return DashboardSummary(
      totalIngresos: ingresos.fold(0.0, (sum, i) => sum + i.monto),
      totalGastosFijos:
          gastosFijos.fold(0.0, (sum, g) => sum + g.monto),
      totalGastosFijosPagados: 0,
      totalGastosVariables:
          gastosVariables.fold(0.0, (sum, g) => sum + g.monto),
      totalDelivery: delivery.fold(0.0, (sum, d) => sum + d.monto),
      presupuestoDelivery:
          double.tryParse(presupuestoRaw ?? '0') ?? 0.0,
      totalAhorros: ahorros.fold(0.0, (sum, a) => sum + a.montoMensual),
    );
  }
}
