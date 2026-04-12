import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/extensions.dart';
import '../../../features/configuracion/providers/configuracion_providers.dart';
import '../../../features/dashboard/providers/dashboard_providers.dart';
import '../../../core/database/app_database.dart';
import '../providers/gastos_fijos_providers.dart';
import 'widgets/add_gasto_fijo_bottom_sheet.dart';
import '../../../shared/widgets/help_bottom_sheet.dart';

class GastosFijosScreen extends ConsumerWidget {
  const GastosFijosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gastosAsync = ref.watch(gastosFijosDelMesProvider);
    final configAsync = ref.watch(configuracionNotifierProvider);
    final month = ref.watch(selectedMonthProvider);

    final simbolo = configAsync.valueOrNull?.simbolo ?? '\$';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.gastosFijos),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Builder(builder: (ctx) {
              final list = gastosAsync.valueOrNull;
              if (list == null) return const SizedBox.shrink();
              final total = list.fold(
                  0.0, (sum, item) => sum + item.gastoFijo.monto);
              final pagados = list
                  .where((item) => item.estaPagado)
                  .fold(0.0, (sum, item) => sum + item.gastoFijo.monto);
              return Text(
                '${CurrencyFormatter.format(pagados, symbol: simbolo)} / '
                '${CurrencyFormatter.format(total, symbol: simbolo)}',
                style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                      color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                    ),
              );
            }),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () => showHelpBottomSheet(
              context,
              title: context.l10n.helpTitulo,
              items: [
                HelpItem(
                    icon: Icons.swipe,
                    text: context.l10n.helpDeslizarEliminar),
                HelpItem(
                    icon: Icons.edit_outlined,
                    text: context.l10n.helpTocarEditar),
                HelpItem(
                    icon: Icons.check_circle_outline,
                    text: context.l10n.helpFijosToggle),
                HelpItem(
                    icon: Icons.info_outline,
                    text: context.l10n.helpFijosSaldo),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showAddGastoFijoBottomSheet(context, ref),
        tooltip: context.l10n.agregarGastoFijo,
        child: const Icon(Icons.add),
      ),
      body: gastosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(
          message: context.l10n.errorGenerico,
          onRetry: () => ref.invalidate(gastosFijosDelMesProvider),
        ),
        data: (items) => items.isEmpty
            ? _EmptyState(mes: month.mes, anio: month.anio)
            : _GastosFijosList(
                items: items,
                simbolo: simbolo,
                mes: month.mes,
                anio: month.anio,
              ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.mes, required this.anio});

  final int mes;
  final int anio;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 64,
                color: theme.colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.4)),
            const SizedBox(height: 16),
            Text(
              l10n.sinGastosFijos,
              style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.sinGastosFijosDesc,
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.7)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ── List ──────────────────────────────────────────────────────────────────────

class _GastosFijosList extends ConsumerWidget {
  const _GastosFijosList({
    required this.items,
    required this.simbolo,
    required this.mes,
    required this.anio,
  });

  final List<GastoFijoConPago> items;
  final String simbolo;
  final int mes;
  final int anio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 96),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return _GastoFijoTile(
          item: item,
          simbolo: simbolo,
          mes: mes,
          anio: anio,
          onEdit: () => showAddGastoFijoBottomSheet(
            context,
            ref,
            gastoFijo: item.gastoFijo,
          ),
        ).animate(delay: (40 * index).ms).fadeIn(duration: 250.ms).slideX(begin: -0.05, curve: Curves.easeOut);
      },
    );
  }
}

// ── Tile ──────────────────────────────────────────────────────────────────────

class _GastoFijoTile extends ConsumerWidget {
  const _GastoFijoTile({
    required this.item,
    required this.simbolo,
    required this.mes,
    required this.anio,
    required this.onEdit,
  });

  final GastoFijoConPago item;
  final String simbolo;
  final int mes;
  final int anio;
  final VoidCallback onEdit;

  Future<bool?> _confirmDelete(BuildContext context) {
    final l10n = context.l10n;
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirmarEliminar),
        content: Text(l10n.confirmarEliminarDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelar),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.expense),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.eliminar),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final gasto = item.gastoFijo;
    final pagado = item.estaPagado;
    final dao = ref.read(appDatabaseProvider).gastosFijosDao;

    return Dismissible(
      key: ValueKey(gasto.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) async {
        await dao.deleteGastoFijo(gasto.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.gastoEliminado)),
          );
        }
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: AppColors.expense,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: pagado
              ? AppColors.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          child: Icon(
            categoriaIcon(gasto.categoria),
            color: pagado
                ? AppColors.primary
                : theme.colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ),
        title: Text(
          gasto.nombre,
          style: theme.textTheme.bodyLarge?.copyWith(
            decoration:
                pagado ? TextDecoration.lineThrough : null,
            color: pagado
                ? theme.colorScheme.onSurfaceVariant
                : null,
          ),
        ),
        subtitle: Text(
          '${gasto.diaVencimiento != null ? l10n.venceElDia(gasto.diaVencimiento!) : l10n.sinFechaVencimiento} · '
          '${categoriaLabel(context, gasto.categoria)}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              CurrencyFormatter.format(gasto.monto, symbol: simbolo),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: pagado
                    ? theme.colorScheme.onSurfaceVariant
                    : AppColors.expense,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: pagado ? l10n.pagado : l10n.pendiente,
              icon: Icon(
                pagado
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked,
                color: pagado
                    ? AppColors.primary
                    : theme.colorScheme.outlineVariant,
              ),
              onPressed: () async {
                if (pagado) {
                  await dao.desmarcarPago(gasto.id, mes, anio);
                } else {
                  await dao.marcarComoPagado(gasto.id, mes, anio);
                }
              },
            ),
          ],
        ),
        onTap: onEdit,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.expense),
          const SizedBox(height: 16),
          Text(message,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(context.l10n.reintentar),
          ),
        ],
      ),
    );
  }
}

