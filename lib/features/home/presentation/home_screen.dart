import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/extensions.dart';
import '../../configuracion/presentation/widgets/onboarding_bottom_sheet.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../../dashboard/providers/dashboard_providers.dart';
import '../../dashboard/providers/dashboard_summary.dart';
import '../../dashboard/providers/dashboard_summary_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _onboardingShown = false;

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(configuracionNotifierProvider);
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final monthState = ref.watch(selectedMonthProvider);

    // Mostrar onboarding si el usuario aún no está configurado
    configAsync.whenData((config) {
      if (!config.estaConfigurado && !_onboardingShown) {
        _onboardingShown = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) showOnboardingBottomSheet(context);
        });
      }
    });

    final config = configAsync.valueOrNull;
    final nombre = config?.nombreUsuario ?? '';
    final summary = summaryAsync.valueOrNull;

    final locale = Localizations.localeOf(context).languageCode;
    final mesLabel = AppDateUtils.monthName(monthState.mes, monthState.anio, locale);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // ── Ícono / logo ───────────────────────────────────────────
              Icon(
                Icons.home_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: -0.2, curve: Curves.easeOut),

              const SizedBox(height: 24),

              // ── Saludo ─────────────────────────────────────────────────
              if (nombre.isNotEmpty)
                Text(
                  context.l10n.hola(nombre),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                )
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 350.ms)
                    .slideY(begin: 0.1, curve: Curves.easeOut),

              const SizedBox(height: 6),

              // ── Fecha actual ───────────────────────────────────────────
              Text(
                mesLabel,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              )
                  .animate(delay: 160.ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.1, curve: Curves.easeOut),

              const SizedBox(height: 32),

              // ── Tarjeta de estado del mes ──────────────────────────────
              if (summary != null)
                _MonthStatusCard(summary: summary)
                    .animate(delay: 240.ms)
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.08, curve: Curves.easeOut),

              if (summary == null)
                const _MonthStatusCardSkeleton()
                    .animate()
                    .fadeIn(duration: 300.ms),

              const Spacer(),

              // ── Botón ingresar ─────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(context.l10n.verMisFinanzas),
                  onPressed: () => context.go('/'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              )
                  .animate(delay: 340.ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.1, curve: Curves.easeOut),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Month status card ─────────────────────────────────────────────────────────

class _MonthStatusCard extends StatelessWidget {
  const _MonthStatusCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final pct = summary.porcentajeComprometido;
    final ratio = (pct / 100).clamp(0.0, 1.0);

    final Color statusColor;
    final String statusLabel;
    if (pct < 70) {
      statusColor = AppColors.primaryLight;
      statusLabel = context.l10n.vasBien;
    } else if (pct < 90) {
      statusColor = AppColors.warning;
      statusLabel = context.l10n.casiAlLimite;
    } else {
      statusColor = AppColors.expense;
      statusLabel = context.l10n.presupuestoComprometido;
    }

    final theme = Theme.of(context);
    final hasFijos = summary.gastosFijosTotalCount > 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título sección
            Text(
              context.l10n.estadoDelMes,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            // Barra de progreso
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 10,
                backgroundColor: statusColor.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
            ),
            const SizedBox(height: 10),

            // Porcentaje + label
            Row(
              children: [
                Text(
                  '${pct.toStringAsFixed(0)}%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  context.l10n.comprometido,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                // Chip de estado
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusLabel,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // Gastos fijos
            if (hasFijos) ...[
              const Divider(height: 28),
              Row(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    context.l10n.pagadosDe(
                      summary.gastosFijosPagadosCount,
                      summary.gastosFijosTotalCount,
                    ),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  // Indicador visual pagados
                  _PaidDotsRow(
                    pagados: summary.gastosFijosPagadosCount,
                    total: summary.gastosFijosTotalCount,
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

// ── Dots row for fijos pagados ────────────────────────────────────────────────

class _PaidDotsRow extends StatelessWidget {
  const _PaidDotsRow({required this.pagados, required this.total});

  final int pagados;
  final int total;

  @override
  Widget build(BuildContext context) {
    // Límite visual: mostrar máximo 8 dots
    final visible = total.clamp(0, 8);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(visible, (i) {
        final isPaid = i < pagados;
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPaid
                ? AppColors.primaryLight
                : Theme.of(context).colorScheme.outlineVariant,
          ),
        );
      }),
    );
  }
}

// ── Skeleton mientras carga ───────────────────────────────────────────────────

class _MonthStatusCardSkeleton extends StatelessWidget {
  const _MonthStatusCardSkeleton();

  @override
  Widget build(BuildContext context) {
    final base =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 14, width: 120, decoration: BoxDecoration(color: base, borderRadius: BorderRadius.circular(4))),
            const SizedBox(height: 16),
            Container(height: 10, decoration: BoxDecoration(color: base, borderRadius: BorderRadius.circular(6))),
            const SizedBox(height: 10),
            Container(height: 14, width: 180, decoration: BoxDecoration(color: base, borderRadius: BorderRadius.circular(4))),
          ],
        ),
      ),
    );
  }
}
