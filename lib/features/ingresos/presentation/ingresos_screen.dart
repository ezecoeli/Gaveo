import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/extensions.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../../dashboard/providers/dashboard_providers.dart';
import '../providers/ingresos_providers.dart';
import 'widgets/add_ingreso_bottom_sheet.dart';

class IngresosScreen extends ConsumerWidget {
  const IngresosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingresosAsync = ref.watch(ingresosDelMesProvider);
    final configAsync = ref.watch(configuracionNotifierProvider);
    final month = ref.watch(selectedMonthProvider);

    final simbolo = configAsync.valueOrNull?.simbolo ?? '\$';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.ingresos),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Builder(builder: (ctx) {
              final list = ingresosAsync.valueOrNull;
              if (list == null) return const SizedBox.shrink();
              final total =
                  list.fold(0.0, (sum, i) => sum + i.monto);
              return Text(
                '${context.l10n.ingresos}: ${CurrencyFormatter.format(total, symbol: simbolo)}',
                style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                      color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                    ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddIngresoBottomSheet(context, ref),
        tooltip: context.l10n.agregarIngreso,
        child: const Icon(Icons.add),
      ),
      body: ingresosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(
          message: context.l10n.errorGenerico,
          onRetry: () => ref.invalidate(ingresosDelMesProvider),
        ),
        data: (items) => items.isEmpty
            ? _EmptyState()
            : _IngresosList(
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
            Icon(Icons.account_balance_wallet_outlined,
                size: 64,
                color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              l10n.sinIngresos,
              style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.sinIngresosDesc,
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

class _IngresosList extends ConsumerWidget {
  const _IngresosList({
    required this.items,
    required this.simbolo,
    required this.mes,
    required this.anio,
  });

  final List<Ingreso> items;
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
        final ingreso = items[index];
        return _IngresoTile(
          ingreso: ingreso,
          simbolo: simbolo,
          onEdit: () => showAddIngresoBottomSheet(
            context,
            ref,
            ingreso: ingreso,
          ),
          onDelete: () async {
            final dao = ref.read(appDatabaseProvider).ingresosDao;
            await dao.deleteIngreso(ingreso.id);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.ingresoEliminado)),
              );
            }
          },
        ).animate(delay: (40 * index).ms).fadeIn(duration: 250.ms).slideX(begin: -0.05, curve: Curves.easeOut);
      },
    );
  }
}

// ── Tile ──────────────────────────────────────────────────────────────────────

class _IngresoTile extends StatelessWidget {
  const _IngresoTile({
    required this.ingreso,
    required this.simbolo,
    required this.onEdit,
    required this.onDelete,
  });

  final Ingreso ingreso;
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(ingreso.id),
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
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(Icons.arrow_downward,
              color: theme.colorScheme.onPrimaryContainer, size: 20),
        ),
        title: Text(ingreso.fuente,
            style: theme.textTheme.bodyLarge),
        subtitle: Text(
          '${ingreso.fecha.day.toString().padLeft(2, '0')}/'
          '${ingreso.fecha.month.toString().padLeft(2, '0')}/'
          '${ingreso.fecha.year}'
          '${ingreso.notas != null && ingreso.notas!.isNotEmpty ? ' · ${ingreso.notas}' : ''}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          CurrencyFormatter.format(ingreso.monto, symbol: simbolo),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
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
          const Icon(Icons.error_outline,
              size: 48, color: AppColors.expense),
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

