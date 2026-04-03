class HistorialMesData {
  final int mes;
  final int anio;
  final double totalIngresos;
  final double totalGastosFijos;
  final double totalVariables;
  final double totalDelivery;
  final double totalAhorros;

  const HistorialMesData({
    required this.mes,
    required this.anio,
    required this.totalIngresos,
    required this.totalGastosFijos,
    required this.totalVariables,
    required this.totalDelivery,
    required this.totalAhorros,
  });

  double get totalGastos =>
      totalGastosFijos + totalVariables + totalDelivery + totalAhorros;

  double get saldo => totalIngresos - totalGastos;

  bool get tieneMovimientos =>
      totalIngresos > 0 || totalVariables > 0 || totalDelivery > 0;
}
