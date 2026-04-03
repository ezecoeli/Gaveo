import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';

part 'ahorros_providers.g.dart';

@riverpod
Stream<List<AhorrosMeta>> ahorrosActivos(
    // ignore: deprecated_member_use_from_same_package
    AhorrosActivosRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.ahorrosDao.watchAhorrosActivos();
}
