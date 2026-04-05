class DashboardSummary {
  final double totalIngresos;
  final double totalGastosFijos;
  final double totalGastosFijosPagados;
  final double totalGastosVariables;
  final double totalAhorros;
  final int gastosFijosPagadosCount;
  final int gastosFijosTotalCount;

  const DashboardSummary({
    required this.totalIngresos,
    required this.totalGastosFijos,
    required this.totalGastosFijosPagados,
    required this.totalGastosVariables,
    required this.totalAhorros,
    this.gastosFijosPagadosCount = 0,
    this.gastosFijosTotalCount = 0,
  });

  double get saldoDisponible =>
      totalIngresos -
      totalGastosFijos -
      totalGastosVariables -
      totalAhorros;

  double get porcentajeComprometido => totalIngresos > 0
      ? (totalGastosFijos + totalAhorros) / totalIngresos * 100
      : 0;

  static const DashboardSummary empty = DashboardSummary(
    totalIngresos: 0,
    totalGastosFijos: 0,
    totalGastosFijosPagados: 0,
    totalGastosVariables: 0,
    totalAhorros: 0,
  );
}
