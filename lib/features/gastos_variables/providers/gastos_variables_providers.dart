import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../dashboard/providers/dashboard_providers.dart';

part 'gastos_variables_providers.g.dart';

@riverpod
Stream<List<GastosVariable>> gastosVariablesDelMes(
    // ignore: deprecated_member_use_from_same_package
    GastosVariablesDelMesRef ref) {
  final db = ref.watch(appDatabaseProvider);
  final month = ref.watch(selectedMonthProvider);
  return db.gastosVariablesDao
      .watchGastosVariablesDelMes(month.mes, month.anio);
}

@riverpod
Stream<List<CategoriasVariablesConfigData>> categoriasDestacadas(
    // ignore: deprecated_member_use_from_same_package
    CategoriasDestacadasRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.categoriasVariablesConfigDao.watchDestacadas();
}
