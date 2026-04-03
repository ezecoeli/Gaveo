import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/extensions.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../../dashboard/providers/dashboard_providers.dart';
import '../providers/gastos_variables_providers.dart';
import 'widgets/add_gasto_variable_bottom_sheet.dart';

class GastosVariablesScreen extends ConsumerWidget {
  const GastosVariablesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gastosAsync = ref.watch(gastosVariablesDelMesProvider);
    final configAsync = ref.watch(configuracionNotifierProvider);
    final month = ref.watch(selectedMonthProvider);

    final simbolo = configAsync.valueOrNull?.simbolo ?? '\$';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.gastosVariables),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Builder(builder: (ctx) {
              final list = gastosAsync.valueOrNull;
              if (list == null) return const SizedBox.shrink();
              final total = list.fold(0.0, (sum, g) => sum + g.monto);
              return Text(
                '${context.l10n.gastosVariables}: ${CurrencyFormatter.format(total, symbol: simbolo)}',
                style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                      color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                    ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddGastoVariableBottomSheet(context, ref),
        tooltip: context.l10n.agregarGastoVariable,
        child: const Icon(Icons.add),
      ),
      body: gastosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(
          message: context.l10n.errorGenerico,
          onRetry: () => ref.invalidate(gastosVariablesDelMesProvider),
        ),
        data: (items) => items.isEmpty
            ? const _EmptyState()
            : _GastosList(
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
  const _EmptyState();

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
            const Icon(Icons.receipt_long_outlined,
                size: 64, color: AppColors.primaryLight),
            const SizedBox(height: 16),
            Text(
              l10n.sinGastosVariables,
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.sinGastosVariablesDesc,
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

class _GastosList extends ConsumerWidget {
  const _GastosList({
    required this.items,
    required this.simbolo,
    required this.mes,
    required this.anio,
  });

  final List<GastosVariable> items;
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
        final gasto = items[index];
        return _GastoTile(
          gasto: gasto,
          simbolo: simbolo,
          onEdit: () => showAddGastoVariableBottomSheet(
            context,
            ref,
            gastoVariable: gasto,
          ),
          onDelete: () async {
            final dao = ref.read(appDatabaseProvider).gastosVariablesDao;
            await dao.deleteGastoVariable(gasto.id);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(context.l10n.gastoVariableEliminado)),
              );
            }
          },
        );
      },
    );
  }
}

// ── Tile ──────────────────────────────────────────────────────────────────────

class _GastoTile extends StatelessWidget {
  const _GastoTile({
    required this.gasto,
    required this.simbolo,
    required this.onEdit,
    required this.onDelete,
  });

  final GastosVariable gasto;
  final String simbolo;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

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
            style:
                FilledButton.styleFrom(backgroundColor: AppColors.expense),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.eliminar),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon = categoriaVariableIcon(gasto.categoria);

    return Dismissible(
      key: ValueKey(gasto.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: AppColors.expense,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.expense.withValues(alpha: 0.1),
          child: Icon(icon, color: AppColors.expense, size: 20),
        ),
        title: Text(gasto.descripcion, style: theme.textTheme.bodyLarge),
        subtitle: Text(
          '${gasto.fecha.day.toString().padLeft(2, '0')}/'
          '${gasto.fecha.month.toString().padLeft(2, '0')}/'
          '${gasto.fecha.year}'
          '${gasto.notas != null && gasto.notas!.isNotEmpty ? ' · ${gasto.notas}' : ''}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          CurrencyFormatter.format(gasto.monto, symbol: simbolo),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.expense,
          ),
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
          Text(message, style: Theme.of(context).textTheme.titleMedium),
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
