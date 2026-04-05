part of '../../../core/database/app_database.dart';

class GastoFijoConPago {
  final GastosFijo gastoFijo;
  final GastosFijosPago? pago;

  const GastoFijoConPago({required this.gastoFijo, this.pago});

  bool get estaPagado => pago?.pagado ?? false;
}

@DriftAccessor(tables: [GastosFijos, GastosFijosPagos])
class GastosFijosDao extends DatabaseAccessor<AppDatabase>
    with _$GastosFijosDaoMixin {
  GastosFijosDao(super.db);

  // Todos los gastos fijos activos con estado de pago (LEFT JOIN lazy)
  Stream<List<GastoFijoConPago>> watchGastosFijosConPago(
      int mes, int anio) {
    final query = select(gastosFijos).join([
      leftOuterJoin(
        gastosFijosPagos,
        gastosFijosPagos.gastoFijoId.equalsExp(gastosFijos.id) &
            gastosFijosPagos.mes.equals(mes) &
            gastosFijosPagos.anio.equals(anio),
      ),
    ])
      ..where(gastosFijos.activo.equals(true))
      ..orderBy([
        // nulls last: sin fecha al final
        OrderingTerm(
          expression: gastosFijos.diaVencimiento,
          mode: OrderingMode.asc,
          nulls: NullsOrder.last,
        )
      ]);

    return query.watch().map(
          (rows) => rows
              .map((row) => GastoFijoConPago(
                    gastoFijo: row.readTable(gastosFijos),
                    pago: row.readTableOrNull(gastosFijosPagos),
                  ))
              .toList(),
        );
  }

  Future<List<GastosFijo>> getGastosFijosActivos() =>
      (select(gastosFijos)..where((t) => t.activo.equals(true))).get();

  Stream<List<GastosFijo>> watchGastosFijosActivos() =>
      (select(gastosFijos)..where((t) => t.activo.equals(true))).watch();

  Future<int> insertGastoFijo(GastosFijosCompanion entry) =>
      into(gastosFijos).insert(entry);

  Future<bool> updateGastoFijo(GastosFijosCompanion entry) =>
      update(gastosFijos).replace(entry);

  Future<int> deleteGastoFijo(int id) =>
      (delete(gastosFijos)..where((t) => t.id.equals(id))).go();

  // Marca como pagado — delete-then-insert en transacción para evitar duplicados
  Future<void> marcarComoPagado(
      int gastoFijoId, int mes, int anio) async {
    await transaction(() async {
      await (delete(gastosFijosPagos)
            ..where((t) =>
                t.gastoFijoId.equals(gastoFijoId) &
                t.mes.equals(mes) &
                t.anio.equals(anio)))
          .go();
      await into(gastosFijosPagos).insert(
        GastosFijosPagosCompanion(
          gastoFijoId: Value(gastoFijoId),
          mes: Value(mes),
          anio: Value(anio),
          pagado: const Value(true),
          fechaPago: Value(DateTime.now()),
        ),
      );
    });
  }

  // Desmarca el pago (elimina el registro)
  Future<int> desmarcarPago(int gastoFijoId, int mes, int anio) =>
      (delete(gastosFijosPagos)
            ..where((t) =>
                t.gastoFijoId.equals(gastoFijoId) &
                t.mes.equals(mes) &
                t.anio.equals(anio)))
          .go();
}
