import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/utils/extensions.dart';

Future<void> showAddIngresoBottomSheet(
  BuildContext context,
  WidgetRef ref, {
  Ingreso? ingreso,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _AddIngresoBottomSheet(ingreso: ingreso),
  );
}

class _AddIngresoBottomSheet extends ConsumerStatefulWidget {
  const _AddIngresoBottomSheet({this.ingreso});

  final Ingreso? ingreso;

  @override
  ConsumerState<_AddIngresoBottomSheet> createState() =>
      _AddIngresoBottomSheetState();
}

class _AddIngresoBottomSheetState
    extends ConsumerState<_AddIngresoBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fuenteCtrl;
  late final TextEditingController _montoCtrl;
  late final TextEditingController _notasCtrl;
  late DateTime _fecha;
  bool _saving = false;

  bool get _isEditing => widget.ingreso != null;

  @override
  void initState() {
    super.initState();
    final i = widget.ingreso;
    _fuenteCtrl = TextEditingController(text: i?.fuente ?? '');
    _montoCtrl = TextEditingController(
      text: i != null ? i.monto.toStringAsFixed(2) : '',
    );
    _notasCtrl = TextEditingController(text: i?.notas ?? '');
    _fecha = i?.fecha ?? DateTime.now();
  }

  @override
  void dispose() {
    _fuenteCtrl.dispose();
    _montoCtrl.dispose();
    _notasCtrl.dispose();
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

    final dao = ref.read(appDatabaseProvider).ingresosDao;
    final fuente = _fuenteCtrl.text.trim();
    final monto = double.parse(_montoCtrl.text.trim().replaceAll(',', '.'));
    final notas = _notasCtrl.text.trim();

    try {
      if (_isEditing) {
        await dao.updateIngreso(IngresosCompanion(
          id: Value(widget.ingreso!.id),
          fuente: Value(fuente),
          monto: Value(monto),
          fecha: Value(_fecha),
          mes: Value(_fecha.month),
          anio: Value(_fecha.year),
          notas: Value(notas.isEmpty ? null : notas),
        ));
      } else {
        await dao.insertIngreso(IngresosCompanion(
          fuente: Value(fuente),
          monto: Value(monto),
          fecha: Value(_fecha),
          mes: Value(_fecha.month),
          anio: Value(_fecha.year),
          notas: Value(notas.isEmpty ? null : notas),
        ));
      }
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? context.l10n.ingresoActualizado
                : context.l10n.ingresoAgregado),
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
            // Handle
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
              _isEditing ? l10n.editarIngreso : l10n.agregarIngreso,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            // Fuente
            TextFormField(
              controller: _fuenteCtrl,
              decoration: InputDecoration(
                labelText: l10n.fuente,
                prefixIcon: const Icon(Icons.work_outline),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLength: 100,
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
            const SizedBox(height: 12),
            // Notas (opcional)
            TextFormField(
              controller: _notasCtrl,
              decoration: InputDecoration(
                labelText: l10n.notasOpcional,
                prefixIcon: const Icon(Icons.notes_outlined),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              maxLength: 200,
            ),
            const SizedBox(height: 20),
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
