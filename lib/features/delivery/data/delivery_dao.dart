part of '../../../core/database/app_database.dart';

@DriftAccessor(tables: [DeliveryGastos])
class DeliveryDao extends DatabaseAccessor<AppDatabase>
    with _$DeliveryDaoMixin {
  DeliveryDao(super.db);

  Stream<List<DeliveryGasto>> watchDeliveryDelMes(int mes, int anio) =>
      (select(deliveryGastos)
            ..where((t) => t.mes.equals(mes) & t.anio.equals(anio))
            ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
          .watch();

  Future<List<DeliveryGasto>> getDeliveryDelMes(int mes, int anio) =>
      (select(deliveryGastos)
            ..where((t) => t.mes.equals(mes) & t.anio.equals(anio)))
          .get();

  Future<int> insertDelivery(DeliveryGastosCompanion entry) =>
      into(deliveryGastos).insert(entry);

  Future<bool> updateDelivery(DeliveryGastosCompanion entry) =>
      update(deliveryGastos).replace(entry);

  Future<int> deleteDelivery(int id) =>
      (delete(deliveryGastos)..where((t) => t.id.equals(id))).go();
}
