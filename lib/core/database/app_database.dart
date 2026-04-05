import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';
part '../../features/ingresos/data/ingresos_dao.dart';
part '../../features/gastos_fijos/data/gastos_fijos_dao.dart';
part '../../features/gastos_variables/data/gastos_variables_dao.dart';
part '../../features/gastos_variables/data/categorias_variables_config_dao.dart';
part '../../features/delivery/data/delivery_dao.dart';
part '../../features/ahorros/data/ahorros_dao.dart';
part '../../features/configuracion/data/configuracion_dao.dart';

// ── Tables ────────────────────────────────────────────────────────────────────

class Ingresos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fuente => text().withLength(min: 1, max: 100)();
  RealColumn get monto => real()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get mes => integer()();
  IntColumn get anio => integer()();
  TextColumn get notas => text().nullable()();
}

class GastosFijos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  RealColumn get monto => real()();
  IntColumn get diaVencimiento => integer().nullable()();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  TextColumn get categoria =>
      text().withDefault(const Constant('general'))();
  TextColumn get notas => text().nullable()();
  BoolColumn get mostrarEnInicio =>
      boolean().withDefault(const Constant(false))();
}

class GastosFijosPagos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get gastoFijoId =>
      integer().references(GastosFijos, #id)();
  IntColumn get mes => integer()();
  IntColumn get anio => integer()();
  BoolColumn get pagado =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get fechaPago => dateTime().nullable()();
}

class GastosVariables extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get descripcion => text().withLength(min: 1, max: 200)();
  RealColumn get monto => real()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get mes => integer()();
  IntColumn get anio => integer()();
  TextColumn get categoria =>
      text().withDefault(const Constant('imprevisto'))();
  TextColumn get notas => text().nullable()();
}

class DeliveryGastos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get descripcion => text().withLength(min: 1, max: 200)();
  RealColumn get monto => real()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get mes => integer()();
  IntColumn get anio => integer()();
  TextColumn get plataforma => text().nullable()();
}

class AhorrosMetas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  RealColumn get montoMensual => real()();
  RealColumn get montoObjetivo => real().nullable()();
  BoolColumn get activo =>
      boolean().withDefault(const Constant(true))();
  TextColumn get emoji =>
      text().withDefault(const Constant('💰'))();
}

class Configuracion extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clave => text().unique()();
  TextColumn get valor => text()();
}

class CategoriasVariablesConfig extends Table {
  TextColumn get categoria => text()();
  RealColumn get limite => real().nullable()();
  BoolColumn get mostrarEnInicio =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {categoria};
}

// ── Database ──────────────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [
    Ingresos,
    GastosFijos,
    GastosFijosPagos,
    GastosVariables,
    DeliveryGastos,
    AhorrosMetas,
    Configuracion,
    CategoriasVariablesConfig,
  ],
  daos: [
    IngresosDao,
    GastosFijosDao,
    GastosVariablesDao,
    CategoriasVariablesConfigDao,
    DeliveryDao,
    AhorrosDao,
    ConfiguracionDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // Migrar registros de delivery_gastos a gastos_variables
            // plataforma → notas para preservar la info
            await customStatement(
              'INSERT OR IGNORE INTO gastos_variables '
              '(descripcion, monto, fecha, mes, anio, categoria, notas) '
              'SELECT descripcion, monto, fecha, mes, anio, \'delivery\', plataforma '
              'FROM delivery_gastos',
            );
          }
          if (from < 3) {
            // Nueva columna en gastos_fijos: mostrar_en_inicio
            await m.addColumn(gastosFijos, gastosFijos.mostrarEnInicio);
            // diaVencimiento ahora es nullable (SQLite ya lo permite, no requiere ALTER)
            // Nueva tabla de configuración de categorías de gastos variables
            await m.createTable(categoriasVariablesConfig);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'gaveo.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

// ── Provider ──────────────────────────────────────────────────────────────────

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('appDatabaseProvider debe ser sobreescrito en main');
});
