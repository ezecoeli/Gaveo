import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../dashboard/providers/dashboard_providers.dart';

part 'delivery_providers.g.dart';

@riverpod
Stream<List<DeliveryGasto>> deliveryDelMes(
    // ignore: deprecated_member_use_from_same_package
    DeliveryDelMesRef ref) {
  final db = ref.watch(appDatabaseProvider);
  final month = ref.watch(selectedMonthProvider);
  return db.deliveryDao.watchDeliveryDelMes(month.mes, month.anio);
}
