import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../dashboard/providers/dashboard_providers.dart';

part 'ingresos_providers.g.dart';

@riverpod
Stream<List<Ingreso>> ingresosDelMes(
    // ignore: deprecated_member_use_from_same_package
    IngresosDelMesRef ref) {
  final db = ref.watch(appDatabaseProvider);
  final month = ref.watch(selectedMonthProvider);
  return db.ingresosDao.watchIngresosDelMes(month.mes, month.anio);
}
