part of '../../../core/database/app_database.dart';

@DriftAccessor(tables: [CategoriasVariablesConfig])
class CategoriasVariablesConfigDao
    extends DatabaseAccessor<AppDatabase>
    with _$CategoriasVariablesConfigDaoMixin {
  CategoriasVariablesConfigDao(super.db);

  /// Devuelve todas las configuraciones de categorías.
  Stream<List<CategoriasVariablesConfigData>> watchAll() =>
      select(categoriasVariablesConfig).watch();

  /// Configura (inserta o actualiza) una categoría.
  Future<void> upsertCategoria(CategoriasVariablesConfigCompanion entry) =>
      into(categoriasVariablesConfig).insertOnConflictUpdate(entry);

  /// Elimina la configuración de una categoría (vuelve a valores por defecto).
  Future<int> deleteCategoria(String categoria) =>
      (delete(categoriasVariablesConfig)
            ..where((t) => t.categoria.equals(categoria)))
          .go();

  /// Categorías que deben aparecer en el dashboard:
  /// las que tienen mostrarEnInicio=true O un límite definido.
  Stream<List<CategoriasVariablesConfigData>> watchDestacadas() {
    return (select(categoriasVariablesConfig)
          ..where(
            (t) =>
                t.mostrarEnInicio.equals(true) |
                t.limite.isNotNull(),
          ))
        .watch();
  }

  /// Obtiene la configuración de una categoría específica.
  Future<CategoriasVariablesConfigData?> getConfigForCategoria(
      String categoria) =>
      (select(categoriasVariablesConfig)
            ..where((t) => t.categoria.equals(categoria)))
          .getSingleOrNull();
}
