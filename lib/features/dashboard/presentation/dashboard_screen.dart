import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/dashboard_providers.dart';
import '../providers/dashboard_summary.dart';
import '../providers/dashboard_summary_provider.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../../gastos_variables/presentation/widgets/add_gasto_variable_bottom_sheet.dart'
    show categoriaVariableLabel, categoriaVariableIcon;
import '../../../../app/theme/app_colors.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/reporte_service.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/help_bottom_sheet.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _notificationsScheduled = false;

  @override
  Widget build(BuildContext context) {
    final monthState = ref.watch(selectedMonthProvider);
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final configAsync = ref.watch(configuracionNotifierProvider);

    // Programar notificaciones una vez por sesión, al cargar los datos
    if (!_notificationsScheduled) {
      ref.listen(dashboardSummaryProvider, (_, next) {
        next.whenData((_) async {
          if (_notificationsScheduled) return;
          _notificationsScheduled = true;
          final config =
              ref.read(configuracionNotifierProvider).valueOrNull;
          if (config?.notificaciones != true) return;
          final db = ref.read(appDatabaseProvider);
          final l10n = context.l10n;
          final gastosFijos =
              await db.gastosFijosDao.getGastosFijosActivos();
          if (!context.mounted) return;
          await NotificationService.scheduleVencimientosMensuales(
            gastosFijos,
            title: l10n.notifVencimientoTitle,
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
        title: GestureDetector(
          onTap: () => context.go('/home'),
          child: const Icon(Icons.home_rounded, size: 30),
        ),
        centerTitle: false,
        titleSpacing: 24,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: _MonthSelector(mes: monthState.mes, anio: monthState.anio),
        ),
        actions: [
          // Botones de acción
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: context.l10n.historial,
            onPressed: () => context.push('/historial'),
          ),
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
                      l10n: context.l10n,
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
    final label = AppDateUtils.monthName(
      mes,
      anio,
      Localizations.localeOf(context).languageCode,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () =>
                ref.read(selectedMonthProvider.notifier).goToPreviousMonth(),
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: canGoNext
                ? () =>
                    ref.read(selectedMonthProvider.notifier).goToNextMonth()
                : null,
          ),
        ],
      ),
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
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      children: [
        _SaldoCard(
            summary: summary,
            simbolo: simbolo,
            nombreUsuario: nombreUsuario,
            onHelpTap: () => showHelpBottomSheet(
              context,
              title: l10n.helpTitulo,
              items: [
                HelpItem(icon: Icons.swap_horiz, text: l10n.helpDashboardMeses),
                HelpItem(
                    icon: Icons.track_changes,
                    text: l10n.helpDashboardSeguimiento),
                HelpItem(
                    icon: Icons.picture_as_pdf_outlined,
                    text: l10n.helpDashboardPDF),
              ],
            ))
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.1, curve: Curves.easeOut),
        const SizedBox(height: 12),
        _SummaryTile(
          label: context.l10n.ingresos,
          amount: summary.totalIngresos,
          simbolo: simbolo,
          color: Theme.of(context).colorScheme.primary,
          icon: Icons.arrow_downward,
        ).animate(delay: 80.ms).fadeIn(duration: 300.ms).slideY(begin: 0.08, curve: Curves.easeOut),
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
        ).animate(delay: 140.ms).fadeIn(duration: 300.ms).slideY(begin: 0.08, curve: Curves.easeOut),
        _SummaryTile(
          label: context.l10n.gastosVariables,
          amount: summary.totalGastosVariables,
          simbolo: simbolo,
          color: AppColors.variable,
          icon: Icons.shopping_bag_outlined,
        ).animate(delay: 200.ms).fadeIn(duration: 300.ms).slideY(begin: 0.08, curve: Curves.easeOut),
        _SummaryTile(
          label: context.l10n.ahorros,
          amount: summary.totalAhorros,
          simbolo: simbolo,
          color: AppColors.savings,
          icon: Icons.savings_outlined,
        ).animate(delay: 260.ms).fadeIn(duration: 300.ms).slideY(begin: 0.08, curve: Curves.easeOut),
        if (summary.trackedItems.isNotEmpty) ...
          _buildSeguimiento(context, summary, simbolo),
        const SizedBox(height: 12),
        _ExpenseBreakdownCard(summary: summary).animate(delay: 320.ms).fadeIn(duration: 300.ms).slideY(begin: 0.08, curve: Curves.easeOut),
      ],
    );
  }

  List<Widget> _buildSeguimiento(
    BuildContext context,
    DashboardSummary summary,
    String simbolo,
  ) {
    return [
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 4),
        child: Text(
          context.l10n.seguimiento,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
      for (int i = 0; i < summary.trackedItems.length; i++)
        _TrackedItemCard(
          item: summary.trackedItems[i],
          simbolo: simbolo,
        )
            .animate(delay: (280 + i * 40).ms)
            .fadeIn(duration: 280.ms)
            .slideY(begin: 0.08, curve: Curves.easeOut),
    ];
  }
}

// ── Saldo card ────────────────────────────────────────────────────────────────

class _SaldoCard extends StatelessWidget {
  const _SaldoCard({
    required this.summary,
    required this.simbolo,
    required this.nombreUsuario,
    this.onHelpTap,
  });

  final DashboardSummary summary;
  final String simbolo;
  final String nombreUsuario;
  final VoidCallback? onHelpTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final saldo = summary.saldoDisponible;
    final saldoColor = saldo >= 0 ? theme.colorScheme.primary : AppColors.expense;
    final pct = summary.porcentajeComprometido;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
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
                      Text(
                        context.l10n.saldoDisponible,
                        style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                if (onHelpTap != null)
                  IconButton(
                    icon: const Icon(Icons.help_outline_rounded),
                    onPressed: onHelpTap,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
              ],
            ),
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
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
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
  });

  final String label;
  final double amount;
  final String simbolo;
  final Color color;
  final IconData icon;
  final String? subtitle;

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
        trailing: Text(
          CurrencyFormatter.format(amount, symbol: simbolo),
          style: theme.textTheme.titleMedium?.copyWith(color: color),
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
          AppColors.variable),
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

// ── Tracked item card ─────────────────────────────────────────────────────────

class _TrackedItemCard extends StatelessWidget {
  const _TrackedItemCard({required this.item, required this.simbolo});

  final TrackedItem item;
  final String simbolo;

  @override
  Widget build(BuildContext context) {
    final ratio = item.limite != null && item.limite! > 0
        ? (item.amount / item.limite!).clamp(0.0, 1.0)
        : null;
    final progressColor = ratio == null
        ? item.color
        : ratio >= 1.0
            ? AppColors.expense
            : ratio >= 0.8
                ? AppColors.warning
                : item.color;
    final displayLabel = item.isCategory
        ? categoriaVariableLabel(context, item.label)
        : item.label;
    final displayIcon = item.isCategory
        ? categoriaVariableIcon(item.label)
        : item.icon;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: item.color.withValues(alpha: 0.15),
                  child: Icon(displayIcon, size: 18, color: item.color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    displayLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(
                  CurrencyFormatter.format(item.amount, symbol: simbolo),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: progressColor,
                      ),
                ),
              ],
            ),
            if (ratio != null) ...
              [
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: ratio,
                    backgroundColor: progressColor.withValues(alpha: 0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(ratio * 100).toStringAsFixed(0)}% ${context.l10n.dePresupuesto}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: progressColor,
                          ),
                    ),
                    Text(
                      '${CurrencyFormatter.format(item.amount, symbol: simbolo)} / ${CurrencyFormatter.format(item.limite!, symbol: simbolo)}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ],
          ],
        ),
      ),
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
