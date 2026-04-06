import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../ahorros/providers/ahorros_providers.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../../gastos_fijos/providers/gastos_fijos_providers.dart';
import '../../gastos_variables/presentation/widgets/add_gasto_variable_bottom_sheet.dart'
    show categoriaVariableIcon;
import '../../gastos_variables/providers/gastos_variables_providers.dart';
import '../../ingresos/providers/ingresos_providers.dart';
import '../../../app/theme/app_colors.dart';
import 'dashboard_summary.dart';

part 'dashboard_summary_provider.g.dart';

/// Reactive dashboard summary — rebuilds automatically whenever any underlying
/// data stream (ingresos, gastos, ahorros) emits a new value.
@riverpod
Future<DashboardSummary> dashboardSummary(
    // ignore: deprecated_member_use_from_same_package
    DashboardSummaryRef ref) async {
  final ingresos = await ref.watch(ingresosDelMesProvider.future);
  final gastosFijosConPago =
      await ref.watch(gastosFijosDelMesProvider.future);
  final gastosVariables =
      await ref.watch(gastosVariablesDelMesProvider.future);
  final ahorros = await ref.watch(ahorrosActivosProvider.future);
  final categoriasDestacadasList =
      await ref.watch(categoriasDestacadasProvider.future);
  await ref.watch(configuracionNotifierProvider.future);

  final pagadosConMonto = gastosFijosConPago.where((g) => g.estaPagado);


  // ── Categorías de variables destacadas ─────────────────────────────────
  final pinnedCategorias = categoriasDestacadasList.map((cfg) {
    final totalCategoria = gastosVariables
        .where((g) => g.categoria == cfg.categoria)
        .fold(0.0, (sum, g) => sum + g.monto);
    return TrackedItem(
      label: cfg.categoria,
      icon: categoriaVariableIcon(cfg.categoria),
      color: AppColors.variable,
      amount: totalCategoria,
      limite: cfg.limite,
      isCategory: true,
    );
  }).toList();

  return DashboardSummary(
    totalIngresos: ingresos.fold(0.0, (sum, i) => sum + i.monto),
    totalGastosFijos:
        gastosFijosConPago.fold(0.0, (sum, g) => sum + g.gastoFijo.monto),
    totalGastosFijosPagados:
        pagadosConMonto.fold(0.0, (sum, g) => sum + g.gastoFijo.monto),
    totalGastosVariables:
        gastosVariables.fold(0.0, (sum, g) => sum + g.monto),
    totalAhorros: ahorros.fold(0.0, (sum, a) => sum + a.montoMensual),
    gastosFijosPagadosCount:
        gastosFijosConPago.where((g) => g.estaPagado).length,
    gastosFijosTotalCount: gastosFijosConPago.length,
    trackedItems: pinnedCategorias,
  );
}
