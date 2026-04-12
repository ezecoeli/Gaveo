import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/extensions.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../providers/ahorros_providers.dart';
import 'widgets/add_ahorro_bottom_sheet.dart';
import '../../../shared/widgets/help_bottom_sheet.dart';

class AhorrosScreen extends ConsumerWidget {
  const AhorrosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ahorrosAsync = ref.watch(ahorrosTodosProvider);
    final configAsync = ref.watch(configuracionNotifierProvider);

    final simbolo = configAsync.valueOrNull?.simbolo ?? '\$';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.ahorros),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Builder(builder: (ctx) {
              final list = ahorrosAsync.valueOrNull;
              if (list == null) return const SizedBox.shrink();
              final total = list
                  .where((a) => a.activo)
                  .fold(0.0, (sum, a) => sum + a.montoMensual);
              return Text(
                '${context.l10n.totalMensual}: ${CurrencyFormatter.format(total, symbol: simbolo)}',
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
                    icon: Icons.visibility_off_outlined,
                    text: context.l10n.helpAhorroInactivo),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddAhorroBottomSheet(context, ref),
        tooltip: context.l10n.agregarMeta,
        child: const Icon(Icons.add),
      ),
      body: ahorrosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(
          message: context.l10n.errorGenerico,
          onRetry: () => ref.invalidate(ahorrosTodosProvider),
        ),
        data: (items) => items.isEmpty
            ? const _EmptyState()
            : _AhorrosList(items: items, simbolo: simbolo),
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
            const Icon(Icons.savings_outlined,
                size: 64, color: AppColors.savings),
            const SizedBox(height: 16),
            Text(
              l10n.sinAhorros,
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.sinAhorrosDesc,
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

class _AhorrosList extends ConsumerWidget {
  const _AhorrosList({required this.items, required this.simbolo});

  final List<AhorrosMeta> items;
  final String simbolo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 96),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final ahorro = items[index];
        return _AhorroTile(
          ahorro: ahorro,
          simbolo: simbolo,
          onEdit: () =>
              showAddAhorroBottomSheet(context, ref, ahorro: ahorro),
          onDelete: () async {
            final dao = ref.read(appDatabaseProvider).ahorrosDao;
            await dao.deleteAhorro(ahorro.id);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(context.l10n.metaEliminada)),
              );
            }
          },
        ).animate(delay: (40 * index).ms).fadeIn(duration: 250.ms).slideX(begin: -0.05, curve: Curves.easeOut);
      },
    );
  }
}

// ── Tile ──────────────────────────────────────────────────────────────────────

class _AhorroTile extends StatelessWidget {
  const _AhorroTile({
    required this.ahorro,
    required this.simbolo,
    required this.onEdit,
    required this.onDelete,
  });

  final AhorrosMeta ahorro;
  final String simbolo;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  Future<bool?> _confirmDelete(BuildContext context) {
    final l10n = context.l10n;
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirmarEliminarMeta),
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
    final l10n = context.l10n;

    return Dismissible(
      key: ValueKey(ahorro.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: AppColors.expense,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Opacity(
        opacity: ahorro.activo ? 1.0 : 0.45,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.savings.withValues(alpha: 0.12),
            child: Icon(
              categoriaAhorroIcon(ahorro.emoji),
              color: AppColors.savings,
              size: 20,
            ),
          ),
          title: Text(ahorro.nombre, style: theme.textTheme.bodyLarge),
          subtitle: !ahorro.activo
              ? Text(
                  l10n.inactivo,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant),
                )
              : ahorro.montoObjetivo != null
                  ? Text(
                      '${l10n.metaLabel}: ${CurrencyFormatter.format(ahorro.montoObjetivo!, symbol: simbolo)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant),
                    )
                  : null,
          trailing: Text(
            CurrencyFormatter.format(ahorro.montoMensual, symbol: simbolo),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.savings,
            ),
          ),
          onTap: onEdit,
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

