part of '../../../core/database/app_database.dart';

@DriftAccessor(tables: [Configuracion])
class ConfiguracionDao extends DatabaseAccessor<AppDatabase>
    with _$ConfiguracionDaoMixin {
  ConfiguracionDao(super.db);

  Stream<String?> watchValor(String clave) =>
      (select(configuracion)..where((t) => t.clave.equals(clave)))
          .watchSingleOrNull()
          .map((row) => row?.valor);

  Future<String?> getValor(String clave) async {
    final row = await (select(configuracion)
          ..where((t) => t.clave.equals(clave)))
        .getSingleOrNull();
    return row?.valor;
  }

  Future<void> setValor(String clave, String valor) async {
    await into(configuracion).insert(
      ConfiguracionCompanion(
        clave: Value(clave),
        valor: Value(valor),
      ),
      onConflict: DoUpdate(
        (_) => ConfiguracionCompanion(valor: Value(valor)),
        target: [configuracion.clave],
      ),
    );
  }

  Stream<Map<String, String>> watchConfiguracion() {
    return select(configuracion).watch().map(
          (rows) => {for (final row in rows) row.clave: row.valor},
        );
  }
}
