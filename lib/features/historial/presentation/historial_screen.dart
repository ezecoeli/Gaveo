import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/extensions.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../../dashboard/providers/dashboard_providers.dart';
import '../data/historial_mes_data.dart';
import '../providers/historial_providers.dart';

class HistorialScreen extends ConsumerWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historialAsync = ref.watch(historialMesesProvider);
    final config = ref.watch(configuracionNotifierProvider).valueOrNull;
    final simbolo = config?.simbolo ?? '\$';
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historial),
      ),
      body: historialAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.expense),
              const SizedBox(height: 12),
              Text(l10n.errorGenerico),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.invalidate(historialMesesProvider),
                child: Text(l10n.reintentar),
              ),
            ],
          ),
        ),
        data: (meses) => ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          itemCount: meses.length,
          itemBuilder: (context, index) => _HistorialMesTile(
            dato: meses[index],
            simbolo: simbolo,
            locale: locale,
            onTap: () {
              ref.read(selectedMonthProvider.notifier).setMonth(
                    meses[index].mes,
                    meses[index].anio,
                  );
              context.go('/');
            },
          ).animate(delay: (50 * index).ms).fadeIn(duration: 300.ms).slideY(begin: 0.06, curve: Curves.easeOut),
        ),
      ),
    );
  }
}

class _HistorialMesTile extends StatelessWidget {
  const _HistorialMesTile({
    required this.dato,
    required this.simbolo,
    required this.locale,
    required this.onTap,
  });

  final HistorialMesData dato;
  final String simbolo;
  final String locale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final saldoPositivo = dato.saldo >= 0;
    final saldoColor = saldoPositivo ? theme.colorScheme.primary : AppColors.expense;
    final mesNombre = AppDateUtils.monthName(dato.mes, dato.anio, locale);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _capitalize(mesNombre),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _AmountChip(
                          icon: Icons.arrow_upward_rounded,
                          color: theme.colorScheme.primary,
                          label: CurrencyFormatter.formatCompact(
                            dato.totalIngresos,
                            symbol: simbolo,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _AmountChip(
                          icon: Icons.arrow_downward_rounded,
                          color: AppColors.expense,
                          label: CurrencyFormatter.formatCompact(
                            dato.totalGastos,
                            symbol: simbolo,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyFormatter.format(dato.saldo, symbol: simbolo),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: saldoColor,
                    ),
                  ),
                  Text(
                    l10n.saldo,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

class _AmountChip extends StatelessWidget {
  const _AmountChip({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
