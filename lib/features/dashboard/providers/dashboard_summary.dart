class DashboardSummary {
  final double totalIngresos;
  final double totalGastosFijos;
  final double totalGastosFijosPagados;
  final double totalGastosVariables;
  final double totalDelivery;
  final double presupuestoDelivery;
  final double totalAhorros;
  final int gastosFijosPagadosCount;
  final int gastosFijosTotalCount;

  const DashboardSummary({
    required this.totalIngresos,
    required this.totalGastosFijos,
    required this.totalGastosFijosPagados,
    required this.totalGastosVariables,
    required this.totalDelivery,
    required this.presupuestoDelivery,
    required this.totalAhorros,
    this.gastosFijosPagadosCount = 0,
    this.gastosFijosTotalCount = 0,
  });

  double get saldoDisponible =>
      totalIngresos -
      totalGastosFijos -
      totalGastosVariables -
      totalDelivery -
      totalAhorros;

  double get porcentajeComprometido => totalIngresos > 0
      ? (totalGastosFijos + totalAhorros) / totalIngresos * 100
      : 0;

  double get porcentajeDelivery =>
      presupuestoDelivery > 0 ? totalDelivery / presupuestoDelivery : 0;

  static const DashboardSummary empty = DashboardSummary(
    totalIngresos: 0,
    totalGastosFijos: 0,
    totalGastosFijosPagados: 0,
    totalGastosVariables: 0,
    totalDelivery: 0,
    presupuestoDelivery: 0,
    totalAhorros: 0,
  );
}
