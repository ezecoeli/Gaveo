import 'package:flutter/material.dart';

// ── Tracked item (pinned on dashboard) ───────────────────────────────────────

class TrackedItem {
  final String label;
  final IconData icon;
  final Color color;
  final double amount;
  final double? limite;
  final bool isCategory;

  const TrackedItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.amount,
    this.limite,
    this.isCategory = false,
  });
}

// ── Dashboard summary ─────────────────────────────────────────────────────────

class DashboardSummary {
  final double totalIngresos;
  final double totalGastosFijos;
  final double totalGastosFijosPagados;
  final double totalGastosVariables;
  final double totalAhorros;
  final int gastosFijosPagadosCount;
  final int gastosFijosTotalCount;
  final List<TrackedItem> trackedItems;

  const DashboardSummary({
    required this.totalIngresos,
    required this.totalGastosFijos,
    required this.totalGastosFijosPagados,
    required this.totalGastosVariables,
    required this.totalAhorros,
    this.gastosFijosPagadosCount = 0,
    this.gastosFijosTotalCount = 0,
    this.trackedItems = const [],
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
