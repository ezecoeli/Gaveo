import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/dashboard_providers.dart';
import '../providers/dashboard_summary.dart';
import '../providers/dashboard_summary_provider.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../../configuracion/presentation/widgets/onboarding_bottom_sheet.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/reporte_service.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/extensions.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _onboardingShown = false;
  bool _notificationsScheduled = false;

  @override
  Widget build(BuildContext context) {
    final monthState = ref.watch(selectedMonthProvider);
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final configAsync = ref.watch(configuracionNotifierProvider);

    configAsync.whenData((config) {
      if (!config.estaConfigurado && !_onboardingShown) {
        _onboardingShown = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) showOnboardingBottomSheet(context);
        });
      }
    });

    // Schedule notifications once per session after data loads
    if (!_notificationsScheduled) {
      ref.listen(dashboardSummaryProvider, (_, next) {
        next.whenData((_) async {
          if (_notificationsScheduled) return;
          _notificationsScheduled = true;
          final db = ref.read(appDatabaseProvider);
          final l10n = context.l10n;
          final gastosFijos =
              await db.gastosFijosDao.getGastosFijosActivos();
          if (!context.mounted) return;
          await NotificationService.scheduleVencimientosHoy(
            gastosFijos,
            bodyBuilder: (nombre) => l10n.notifVencimientoBody(nombre),
          );
        });
      });
    }

    final config = configAsync.valueOrNull;
    final simbolo = config?.simbolo ?? '\$';
    final nombreUsuario = config?.nombreUsuario ?? '';

    return Scaffold(
      appBar: AppBar(
        title: _MonthSelector(mes: monthState.mes, anio: monthState.anio),
        centerTitle: true,
        actions: [
          // Export PDF
          summaryAsync.whenOrNull(
                data: (summary) => IconButton(
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  tooltip: context.l10n.exportarPDF,
                  onPressed: () async {
                    if (config == null) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(context.l10n.generandoPDF),
                          duration: const Duration(seconds: 1)),
                    );
                    await ReporteService.compartirResumenMensual(
                      summary: summary,
                      config: config,
                      mes: monthState.mes,
                      anio: monthState.anio,
                      locale: Localizations.localeOf(context).languageCode,
                    );
                  },
                ),
              ) ??
              const SizedBox.shrink(),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/configuracion'),
          ),
        ],
      ),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(
          message: context.l10n.errorGenerico,
          onRetry: () => ref.invalidate(dashboardSummaryProvider),
        ),
        data: (summary) => _DashboardBody(
          summary: summary,
          simbolo: simbolo,
          nombreUsuario: nombreUsuario,
        ),
      ),
    );
  }
}

// ── Month selector ────────────────────────────────────────────────────────────

class _MonthSelector extends ConsumerWidget {
  const _MonthSelector({required this.mes, required this.anio});

  final int mes;
  final int anio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canGoNext = AppDateUtils.canGoToNextMonth(mes, anio);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () =>
              ref.read(selectedMonthProvider.notifier).goToPreviousMonth(),
        ),
        Text(AppDateUtils.monthName(
          mes,
          anio,
          Localizations.localeOf(context).languageCode,
        )),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: canGoNext
              ? () =>
                  ref.read(selectedMonthProvider.notifier).goToNextMonth()
              : null,
        ),
      ],
    );
  }
}

// ── Body ──────────────────────────────────────────────────────────────────────

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({
    required this.summary,
    required this.simbolo,
    required this.nombreUsuario,
  });

  final DashboardSummary summary;
  final String simbolo;
  final String nombreUsuario;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      children: [
        _SaldoCard(
            summary: summary,
            simbolo: simbolo,
            nombreUsuario: nombreUsuario),
        const SizedBox(height: 12),
        _SummaryTile(
          label: context.l10n.ingresos,
          amount: summary.totalIngresos,
          simbolo: simbolo,
          color: AppColors.income,
          icon: Icons.arrow_downward,
          onTap: () => context.push('/ingresos'),
        ),
        _SummaryTile(
          label: context.l10n.gastosFijos,
          amount: summary.totalGastosFijos,
          simbolo: simbolo,
          color: AppColors.expense,
          icon: Icons.receipt_long,
          subtitle: summary.gastosFijosTotalCount > 0
              ? context.l10n.pagadosDe(
                  summary.gastosFijosPagadosCount,
                  summary.gastosFijosTotalCount,
                )
              : null,
        ),
        _SummaryTile(
          label: context.l10n.gastosVariables,
          amount: summary.totalGastosVariables,
          simbolo: simbolo,
          color: AppColors.expense,
          icon: Icons.shopping_bag_outlined,
        ),
        _DeliveryTile(summary: summary, simbolo: simbolo),
        _SummaryTile(
          label: context.l10n.ahorros,
          amount: summary.totalAhorros,
          simbolo: simbolo,
          color: AppColors.savings,
          icon: Icons.savings_outlined,
        ),
        const SizedBox(height: 12),
        _ExpenseBreakdownCard(summary: summary),
      ],
    );
  }
}

// ── Saldo card ────────────────────────────────────────────────────────────────

class _SaldoCard extends StatelessWidget {
  const _SaldoCard({
    required this.summary,
    required this.simbolo,
    required this.nombreUsuario,
  });

  final DashboardSummary summary;
  final String simbolo;
  final String nombreUsuario;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final saldo = summary.saldoDisponible;
    final saldoColor = saldo >= 0 ? AppColors.income : AppColors.expense;
    final pct = summary.porcentajeComprometido;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (nombreUsuario.isNotEmpty) ...[
              Text(
                context.l10n.hola(nombreUsuario),
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
            ],
            Text(context.l10n.saldoDisponible,
                style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 4),
            Text(
              CurrencyFormatter.format(saldo, symbol: simbolo),
              style: theme.textTheme.displaySmall?.copyWith(
                color: saldoColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (pct / 100).clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  pct > 100
                      ? AppColors.expense
                      : pct > 90
                          ? AppColors.warning
                          : AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              context.l10n.porcentajeComprometido(
                  pct.toStringAsFixed(0)),
              style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Summary tile ──────────────────────────────────────────────────────────────

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.amount,
    required this.simbolo,
    required this.color,
    required this.icon,
    this.subtitle,
    this.onTap,
  });

  final String label;
  final double amount;
  final String simbolo;
  final Color color;
  final IconData icon;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(label, style: theme.textTheme.bodyMedium),
        subtitle: subtitle != null
            ? Text(subtitle!,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant))
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              CurrencyFormatter.format(amount, symbol: simbolo),
              style: theme.textTheme.titleMedium?.copyWith(color: color),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              Icon(Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant, size: 18),
            ],
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

// ── Delivery tile (with budget bar) ──────────────────────────────────────────

class _DeliveryTile extends StatelessWidget {
  const _DeliveryTile({required this.summary, required this.simbolo});

  final DashboardSummary summary;
  final String simbolo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratio = summary.porcentajeDelivery;
    final color = ratio >= AppConstants.errorDeliveryPct
        ? AppColors.expense
        : ratio >= AppConstants.warningDeliveryPct
            ? AppColors.warning
            : AppColors.delivery;
    final hasBudget = summary.presupuestoDelivery > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.12),
                  child:
                      Icon(Icons.delivery_dining, color: color, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(context.l10n.delivery,
                      style: theme.textTheme.bodyMedium),
                ),
                Text(
                  CurrencyFormatter.format(summary.totalDelivery,
                      symbol: simbolo),
                  style: theme.textTheme.titleMedium?.copyWith(color: color),
                ),
              ],
            ),
            if (hasBudget) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: ratio.clamp(0.0, 1.0),
                  minHeight: 6,
                  backgroundColor: color.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.gastadoDe(
                  CurrencyFormatter.format(summary.totalDelivery,
                      symbol: simbolo),
                  CurrencyFormatter.format(summary.presupuestoDelivery,
                      symbol: simbolo),
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Expense breakdown chart ───────────────────────────────────────────────────

class _ExpenseBreakdownCard extends StatelessWidget {
  const _ExpenseBreakdownCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    final data = [
      (l10n.gastosFijos, summary.totalGastosFijos, AppColors.expense),
      (l10n.gastosVariables, summary.totalGastosVariables,
          const Color(0xFFE57373)),
      (l10n.delivery, summary.totalDelivery, AppColors.delivery),
      (l10n.ahorros, summary.totalAhorros, AppColors.savings),
    ].where((e) => e.$2 > 0).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.distribucionGastos,
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            if (data.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(l10n.sinDatosGrafico,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                ),
              )
            else ...[
              SizedBox(
                height: 180,
                child: PieChart(
                  PieChartData(
                    sections: data
                        .map((e) => PieChartSectionData(
                              value: e.$2,
                              color: e.$3,
                              title: '',
                              radius: 55,
                            ))
                        .toList(),
                    centerSpaceRadius: 45,
                    sectionsSpace: 2,
                    startDegreeOffset: -90,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: data
                    .map((e) => _LegendItem(
                          color: e.$3,
                          label: e.$1,
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

// ── Error view ────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline,
                size: 48, color: AppColors.expense),
            const SizedBox(height: 16),
            Text(context.l10n.errorGenerico,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(context.l10n.reintentar),
            ),
          ],
        ),
      ),
    );
  }
}
