import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart' hide ConfiguracionData;
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/extensions.dart';
import '../../configuracion/providers/configuracion_providers.dart';
import '../../dashboard/providers/dashboard_providers.dart';
import '../providers/delivery_providers.dart';
import 'widgets/add_delivery_bottom_sheet.dart';

class DeliveryScreen extends ConsumerWidget {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryAsync = ref.watch(deliveryDelMesProvider);
    final configAsync = ref.watch(configuracionNotifierProvider);
    final month = ref.watch(selectedMonthProvider);

    final config = configAsync.valueOrNull;
    final simbolo = config?.simbolo ?? '\$';
    final presupuesto = config?.presupuestoDelivery ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.delivery),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Builder(builder: (ctx) {
              final list = deliveryAsync.valueOrNull;
              if (list == null) return const SizedBox.shrink();
              final total = list.fold(0.0, (sum, d) => sum + d.monto);
              return Text(
                '${context.l10n.gastadoLabel}: ${CurrencyFormatter.format(total, symbol: simbolo)}',
                style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                      color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                    ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddDeliveryBottomSheet(context, ref),
        tooltip: context.l10n.agregarDelivery,
        child: const Icon(Icons.add),
      ),
      body: deliveryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(
          message: context.l10n.errorGenerico,
          onRetry: () => ref.invalidate(deliveryDelMesProvider),
        ),
        data: (items) {
          final total = items.fold(0.0, (sum, d) => sum + d.monto);
          return Column(
            children: [
              _BudgetBar(
                total: total,
                presupuesto: presupuesto,
                simbolo: simbolo,
                onEdit: () => _showPresupuestoSheet(
                  context,
                  ref,
                  presupuesto: presupuesto,
                  config: config!,
                  simbolo: simbolo,
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? const _EmptyState()
                    : _DeliveryList(
                        items: items,
                        simbolo: simbolo,
                        mes: month.mes,
                        anio: month.anio,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Future<void> _showPresupuestoSheet(
    BuildContext context,
    WidgetRef ref, {
    required double presupuesto,
    required ConfiguracionData config,
    required String simbolo,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _PresupuestoSheet(
        presupuesto: presupuesto,
        config: config,
        simbolo: simbolo,
        ref: ref,
      ),
    );
  }
}

// ── Presupuesto sheet ─────────────────────────────────────────────────────────

class _PresupuestoSheet extends StatefulWidget {
  const _PresupuestoSheet({
    required this.presupuesto,
    required this.config,
    required this.simbolo,
    required this.ref,
  });

  final double presupuesto;
  final ConfiguracionData config;
  final String simbolo;
  final WidgetRef ref;

  @override
  State<_PresupuestoSheet> createState() => _PresupuestoSheetState();
}

class _PresupuestoSheetState extends State<_PresupuestoSheet> {
  late final TextEditingController _ctrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(
      text: widget.presupuesto > 0
          ? widget.presupuesto.toStringAsFixed(2)
          : '',
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final valor = double.tryParse(_ctrl.text.trim()) ?? 0.0;
    setState(() => _saving = true);
    try {
      await widget.ref
          .read(configuracionNotifierProvider.notifier)
          .guardar(
            nombreUsuario: widget.config.nombreUsuario,
            moneda: widget.config.moneda,
            simbolo: widget.config.simbolo,
            presupuestoDelivery: valor,
            idioma: widget.config.idioma,
            tema: widget.config.tema,
          );
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(l10n.presupuestoDelivery,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextFormField(
            controller: _ctrl,
            autofocus: true,
            decoration: InputDecoration(
              labelText: l10n.presupuestoDeliveryOpcional,
              prefixIcon: const Icon(Icons.delivery_dining_outlined),
              prefixText: '${widget.simbolo} ',
            ),
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d{0,10}(\.\d{0,2})?')),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saving ? null : _guardar,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(l10n.guardar),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Budget bar ────────────────────────────────────────────────────────────────

class _BudgetBar extends StatelessWidget {
  const _BudgetBar({
    required this.total,
    required this.presupuesto,
    required this.simbolo,
    required this.onEdit,
  });

  final double total;
  final double presupuesto;
  final String simbolo;
  final VoidCallback onEdit;

  Color _barColor() {
    if (presupuesto <= 0) return AppColors.delivery;
    final ratio = total / presupuesto;
    if (ratio >= AppConstants.errorDeliveryPct) return AppColors.expense;
    if (ratio >= AppConstants.warningDeliveryPct) return AppColors.warning;
    return AppColors.delivery;
  }

  Color _textIconColor() {
    if (presupuesto <= 0) return AppColors.delivery;
    final ratio = total / presupuesto;
    if (ratio >= AppConstants.warningDeliveryPct) return AppColors.expense;
    return AppColors.delivery;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final color = _barColor();
    final textColor = _textIconColor();
    final progress = presupuesto > 0
        ? (total / presupuesto).clamp(0.0, 1.0)
        : 0.0;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.gastadoLabel,
                    style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      presupuesto > 0
                          ? l10n.presupuestoLabel
                          : l10n.presupuestoNoDefinido,
                      style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: onEdit,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.edit_outlined,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CurrencyFormatter.format(total, symbol: simbolo),
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: textColor),
                ),
                if (presupuesto > 0)
                  Text(
                    CurrencyFormatter.format(presupuesto, symbol: simbolo),
                    style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurfaceVariant),
                  ),
              ],
            ),
            if (presupuesto > 0) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: color.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ],
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
            const Icon(Icons.delivery_dining_outlined,
                size: 64, color: AppColors.delivery),
            const SizedBox(height: 16),
            Text(
              l10n.sinDelivery,
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.sinDeliveryDesc,
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

class _DeliveryList extends ConsumerWidget {
  const _DeliveryList({
    required this.items,
    required this.simbolo,
    required this.mes,
    required this.anio,
  });

  final List<DeliveryGasto> items;
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
        final delivery = items[index];
        return _DeliveryTile(
          delivery: delivery,
          simbolo: simbolo,
          onEdit: () => showAddDeliveryBottomSheet(
            context,
            ref,
            delivery: delivery,
          ),
          onDelete: () async {
            final dao = ref.read(appDatabaseProvider).deliveryDao;
            await dao.deleteDelivery(delivery.id);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(context.l10n.deliveryEliminado)),
              );
            }
          },
        ).animate(delay: (40 * index).ms).fadeIn(duration: 250.ms).slideX(begin: -0.05, curve: Curves.easeOut);
      },
    );
  }
}

// ── Tile ──────────────────────────────────────────────────────────────────────

class _DeliveryTile extends StatelessWidget {
  const _DeliveryTile({
    required this.delivery,
    required this.simbolo,
    required this.onEdit,
    required this.onDelete,
  });

  final DeliveryGasto delivery;
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

    return Dismissible(
      key: ValueKey(delivery.id),
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
          backgroundColor: AppColors.delivery.withValues(alpha: 0.1),
          child: const Icon(Icons.delivery_dining,
              color: AppColors.delivery, size: 20),
        ),
        title: Text(delivery.descripcion, style: theme.textTheme.bodyLarge),
        subtitle: Text(
          '${delivery.fecha.day.toString().padLeft(2, '0')}/'
          '${delivery.fecha.month.toString().padLeft(2, '0')}/'
          '${delivery.fecha.year}'
          '${delivery.plataforma != null && delivery.plataforma!.isNotEmpty ? ' · ${delivery.plataforma}' : ''}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          CurrencyFormatter.format(delivery.monto, symbol: simbolo),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.delivery,
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

