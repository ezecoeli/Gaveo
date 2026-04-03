import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/utils/extensions.dart';

Future<void> showAddDeliveryBottomSheet(
  BuildContext context,
  WidgetRef ref, {
  DeliveryGasto? delivery,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _AddDeliveryBottomSheet(delivery: delivery),
  );
}

class _AddDeliveryBottomSheet extends ConsumerStatefulWidget {
  const _AddDeliveryBottomSheet({this.delivery});

  final DeliveryGasto? delivery;

  @override
  ConsumerState<_AddDeliveryBottomSheet> createState() =>
      _AddDeliveryBottomSheetState();
}

class _AddDeliveryBottomSheetState
    extends ConsumerState<_AddDeliveryBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descCtrl;
  late final TextEditingController _montoCtrl;
  late final TextEditingController _plataformaCtrl;
  late DateTime _fecha;
  bool _saving = false;

  bool get _isEditing => widget.delivery != null;

  @override
  void initState() {
    super.initState();
    final d = widget.delivery;
    _descCtrl = TextEditingController(text: d?.descripcion ?? '');
    _montoCtrl = TextEditingController(
      text: d != null ? d.monto.toStringAsFixed(2) : '',
    );
    _plataformaCtrl = TextEditingController(text: d?.plataforma ?? '');
    _fecha = d?.fecha ?? DateTime.now();
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    _montoCtrl.dispose();
    _plataformaCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 31)),
    );
    if (picked != null) setState(() => _fecha = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final dao = ref.read(appDatabaseProvider).deliveryDao;
    final desc = _descCtrl.text.trim();
    final monto = double.parse(_montoCtrl.text.trim().replaceAll(',', '.'));
    final plataforma = _plataformaCtrl.text.trim();

    try {
      if (_isEditing) {
        await dao.updateDelivery(DeliveryGastosCompanion(
          id: Value(widget.delivery!.id),
          descripcion: Value(desc),
          monto: Value(monto),
          fecha: Value(_fecha),
          mes: Value(_fecha.month),
          anio: Value(_fecha.year),
          plataforma: Value(plataforma.isEmpty ? null : plataforma),
        ));
      } else {
        await dao.insertDelivery(DeliveryGastosCompanion(
          descripcion: Value(desc),
          monto: Value(monto),
          fecha: Value(_fecha),
          mes: Value(_fecha.month),
          anio: Value(_fecha.year),
          plataforma: Value(plataforma.isEmpty ? null : plataforma),
        ));
      }
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? context.l10n.deliveryActualizado
                : context.l10n.deliveryAgregado),
          ),
        );
      }
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
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              _isEditing ? l10n.editarDelivery : l10n.agregarDelivery,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            // Descripción
            TextFormField(
              controller: _descCtrl,
              decoration: InputDecoration(
                labelText: l10n.descripcion,
                prefixIcon: const Icon(Icons.delivery_dining_outlined),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLength: 200,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? l10n.campoRequerido
                  : null,
            ),
            const SizedBox(height: 12),
            // Monto
            TextFormField(
              controller: _montoCtrl,
              decoration: InputDecoration(
                labelText: l10n.monto,
                prefixIcon: const Icon(Icons.attach_money),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
              ],
              validator: (v) {
                if (v == null || v.trim().isEmpty) return l10n.campoRequerido;
                final n = double.tryParse(v.trim().replaceAll(',', '.'));
                if (n == null || n <= 0) return l10n.montoInvalido;
                return null;
              },
            ),
            const SizedBox(height: 12),
            // Plataforma (opcional)
            TextFormField(
              controller: _plataformaCtrl,
              decoration: InputDecoration(
                labelText: l10n.plataformaOpcional,
                prefixIcon: const Icon(Icons.smartphone_outlined),
              ),
              textCapitalization: TextCapitalization.words,
              maxLength: 50,
            ),
            const SizedBox(height: 12),
            // Fecha
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: l10n.fecha,
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  suffixIcon: const Icon(Icons.chevron_right),
                ),
                child: Text(
                  '${_fecha.day.toString().padLeft(2, '0')}/'
                  '${_fecha.month.toString().padLeft(2, '0')}/'
                  '${_fecha.year}',
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
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
      ),
    );
  }
}
