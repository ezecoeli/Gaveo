import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/dashboard_providers.dart';
import '../providers/dashboard_summary.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../../configuracion/presentation/widgets/onboarding_bottom_sheet.dart';
import '../../../../app/theme/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    final monthState = ref.watch(selectedMonthProvider);
    final summaryAsync = ref.watch(dashboardNotifierProvider);
    final configAsync = ref.watch(configuracionNotifierProvider);

    // Show onboarding once when config loads and user is not set up yet.
    configAsync.whenData((config) {
      if (!config.estaConfigurado && !_onboardingShown) {
        _onboardingShown = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) showOnboardingBottomSheet(context);
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: _MonthSelector(mes: monthState.mes, anio: monthState.anio),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/configuracion'),
          ),
        ],
      ),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(dashboardNotifierProvider),
        ),
        data: (summary) => _DashboardBody(summary: summary),
      ),
    );
  }
}

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

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SaldoCard(summary: summary),
        const SizedBox(height: 16),
        _SummaryRow(summary: summary),
      ],
    );
  }
}

class _SaldoCard extends StatelessWidget {
  const _SaldoCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final saldo = summary.saldoDisponible;
    final saldoColor = saldo >= 0 ? AppColors.income : AppColors.expense;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.saldoDisponible, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(
              CurrencyFormatter.format(saldo),
              style: theme.textTheme.displayMedium?.copyWith(
                color: saldoColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: (summary.porcentajeComprometido / 100).clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade200,
              color: summary.porcentajeComprometido > 90
                  ? AppColors.expense
                  : AppColors.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 4),
            Text(
              context.l10n.porcentajeComprometido(
                summary.porcentajeComprometido.toStringAsFixed(0),
              ),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SummaryTile(
          label: context.l10n.ingresos,
          amount: summary.totalIngresos,
          color: AppColors.income,
          icon: Icons.arrow_downward,
          onTap: () => context.push('/ingresos'),
        ),
        _SummaryTile(
          label: context.l10n.gastosFijos,
          amount: summary.totalGastosFijos,
          color: AppColors.expense,
          icon: Icons.receipt_long,
        ),
        _SummaryTile(
          label: context.l10n.gastosVariables,
          amount: summary.totalGastosVariables,
          color: AppColors.expense,
          icon: Icons.shopping_bag,
        ),
        _SummaryTile(
          label: context.l10n.delivery,
          amount: summary.totalDelivery,
          color: AppColors.delivery,
          icon: Icons.delivery_dining,
        ),
        _SummaryTile(
          label: context.l10n.ahorros,
          amount: summary.totalAhorros,
          color: AppColors.savings,
          icon: Icons.savings,
        ),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
    this.onTap,
  });

  final String label;
  final double amount;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha(30),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(label, style: theme.textTheme.bodyMedium),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              CurrencyFormatter.format(amount),
              style: theme.textTheme.titleMedium?.copyWith(color: color),
            ),
            if (onTap != null) ...
              [const SizedBox(width: 4), Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant, size: 18)],
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({required this.message, required this.onRetry});

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
            const Icon(Icons.error_outline, size: 48, color: AppColors.expense),
            const SizedBox(height: 16),
            Text(context.l10n.errorGenerico, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: onRetry, child: Text(context.l10n.reintentar)),
          ],
        ),
      ),
    );
  }
}
