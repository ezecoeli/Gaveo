import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../data/historial_mes_data.dart';

part 'historial_providers.g.dart';

/// Returns monthly summaries for the last 12 months (newest first).
/// Gastos fijos and ahorros are recurring — same total for every month.
@riverpod
Future<List<HistorialMesData>> historialMeses(
    // ignore: deprecated_member_use_from_same_package
    HistorialMesesRef ref) async {
  final db = ref.watch(appDatabaseProvider);

  // Recurring totals — same for every month
  final gastosFijosActivos = await db.gastosFijosDao.getGastosFijosActivos();
  final ahorrosActivos = await db.ahorrosDao.getAhorrosActivos();
  final totalFijos =
      gastosFijosActivos.fold(0.0, (sum, g) => sum + g.monto);
  final totalAhorros =
      ahorrosActivos.fold(0.0, (sum, a) => sum + a.montoMensual);

  // Generate last 12 months (newest first)
  final now = DateTime.now();
  final result = <HistorialMesData>[];

  for (int i = 0; i < 12; i++) {
    int mes = now.month - i;
    int anio = now.year;
    if (mes <= 0) {
      mes += 12;
      anio -= 1;
    }

    final ingresos = await db.ingresosDao.getIngresosDelMes(mes, anio);
    final variables =
        await db.gastosVariablesDao.getGastosVariablesDelMes(mes, anio);

    result.add(HistorialMesData(
      mes: mes,
      anio: anio,
      totalIngresos: ingresos.fold(0.0, (sum, i) => sum + i.monto),
      totalGastosFijos: totalFijos,
      totalVariables: variables.fold(0.0, (sum, v) => sum + v.monto),
      totalAhorros: totalAhorros,
    ));
  }

  return result;
}
