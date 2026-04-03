part of '../../../core/database/app_database.dart';

@DriftAccessor(tables: [GastosVariables])
class GastosVariablesDao extends DatabaseAccessor<AppDatabase>
    with _$GastosVariablesDaoMixin {
  GastosVariablesDao(super.db);

  Stream<List<GastosVariable>> watchGastosVariablesDelMes(
          int mes, int anio) =>
      (select(gastosVariables)
            ..where((t) => t.mes.equals(mes) & t.anio.equals(anio))
            ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
          .watch();

  Future<List<GastosVariable>> getGastosVariablesDelMes(
          int mes, int anio) =>
      (select(gastosVariables)
            ..where((t) => t.mes.equals(mes) & t.anio.equals(anio)))
          .get();

  Future<int> insertGastoVariable(GastosVariablesCompanion entry) =>
      into(gastosVariables).insert(entry);

  Future<bool> updateGastoVariable(GastosVariablesCompanion entry) =>
      update(gastosVariables).replace(entry);

  Future<int> deleteGastoVariable(int id) =>
      (delete(gastosVariables)..where((t) => t.id.equals(id))).go();
}
