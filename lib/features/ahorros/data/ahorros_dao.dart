part of '../../../core/database/app_database.dart';

@DriftAccessor(tables: [AhorrosMetas])
class AhorrosDao extends DatabaseAccessor<AppDatabase>
    with _$AhorrosDaoMixin {
  AhorrosDao(super.db);

  Stream<List<AhorrosMeta>> watchAhorrosActivos() =>
      (select(ahorrosMetas)
            ..where((t) => t.activo.equals(true))
            ..orderBy([(t) => OrderingTerm.asc(t.nombre)]))
          .watch();

  Future<List<AhorrosMeta>> getAhorrosActivos() =>
      (select(ahorrosMetas)..where((t) => t.activo.equals(true))).get();

  Stream<List<AhorrosMeta>> watchTodosLosAhorros() =>
      (select(ahorrosMetas)
            ..orderBy([
              (t) => OrderingTerm.desc(t.activo),
              (t) => OrderingTerm.asc(t.nombre),
            ]))
          .watch();

  Future<int> insertAhorro(AhorrosMetasCompanion entry) =>
      into(ahorrosMetas).insert(entry);

  Future<bool> updateAhorro(AhorrosMetasCompanion entry) =>
      update(ahorrosMetas).replace(entry);

  Future<int> deleteAhorro(int id) =>
      (delete(ahorrosMetas)..where((t) => t.id.equals(id))).go();
}
