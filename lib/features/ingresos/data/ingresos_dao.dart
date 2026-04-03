part of '../../../core/database/app_database.dart';

@DriftAccessor(tables: [Ingresos])
class IngresosDao extends DatabaseAccessor<AppDatabase>
    with _$IngresosDaoMixin {
  IngresosDao(super.db);

  Stream<List<Ingreso>> watchIngresosDelMes(int mes, int anio) =>
      (select(ingresos)
            ..where((t) => t.mes.equals(mes) & t.anio.equals(anio))
            ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
          .watch();

  Future<List<Ingreso>> getIngresosDelMes(int mes, int anio) =>
      (select(ingresos)
            ..where((t) => t.mes.equals(mes) & t.anio.equals(anio)))
          .get();

  Future<int> insertIngreso(IngresosCompanion entry) =>
      into(ingresos).insert(entry);

  Future<bool> updateIngreso(IngresosCompanion entry) =>
      update(ingresos).replace(entry);

  Future<int> deleteIngreso(int id) =>
      (delete(ingresos)..where((t) => t.id.equals(id))).go();
}
