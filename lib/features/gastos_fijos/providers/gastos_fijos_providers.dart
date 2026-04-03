import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../dashboard/providers/dashboard_providers.dart';

part 'gastos_fijos_providers.g.dart';

@riverpod
Stream<List<GastoFijoConPago>> gastosFijosDelMes(
    // ignore: deprecated_member_use_from_same_package
    GastosFijosDelMesRef ref) {
  final db = ref.watch(appDatabaseProvider);
  final month = ref.watch(selectedMonthProvider);
  return db.gastosFijosDao.watchGastosFijosConPago(month.mes, month.anio);
}
