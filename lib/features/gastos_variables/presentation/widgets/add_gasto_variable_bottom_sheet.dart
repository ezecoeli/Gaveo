import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/utils/extensions.dart';

// ── Categorías ────────────────────────────────────────────────────────────────

const List<String> kCategoriasVariables = [
  'imprevisto',
  'comida',
  'transporte',
  'ropa',
  'entretenimiento',
  'farmacia',
  'hogar',
  'otro',
];

IconData categoriaVariableIcon(String categoria) => switch (categoria) {
      'comida' => Icons.restaurant_outlined,
      'transporte' => Icons.directions_car_outlined,
      'ropa' => Icons.checkroom_outlined,
      'entretenimiento' => Icons.movie_outlined,
      'farmacia' => Icons.local_pharmacy_outlined,
      'hogar' => Icons.home_outlined,
      'otro' => Icons.category_outlined,
      _ => Icons.error_outline, // imprevisto
    };

String categoriaVariableLabel(BuildContext context, String categoria) {
  final l = context.l10n;
  return switch (categoria) {
    'comida' => l.catComida,
    'transporte' => l.catTransporte,
    'ropa' => l.catRopa,
    'entretenimiento' => l.catEntretenimiento,
    'farmacia' => l.catFarmacia,
    'hogar' => l.catHogar,
    'otro' => l.catOtro,
    _ => l.catImprevisto,
  };
}

// ── Bottom sheet ──────────────────────────────────────────────────────────────

Future<void> showAddGastoVariableBottomSheet(
  BuildContext context,
  WidgetRef ref, {
  GastosVariable? gastoVariable,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) =>
        _AddGastoVariableBottomSheet(gastoVariable: gastoVariable),
  );
}

class _AddGastoVariableBottomSheet extends ConsumerStatefulWidget {
  const _AddGastoVariableBottomSheet({this.gastoVariable});

  final GastosVariable? gastoVariable;

  @override
  ConsumerState<_AddGastoVariableBottomSheet> createState() =>
      _AddGastoVariableBottomSheetState();
}

class _AddGastoVariableBottomSheetState
    extends ConsumerState<_AddGastoVariableBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descCtrl;
  late final TextEditingController _montoCtrl;
  late final TextEditingController _notasCtrl;
  late DateTime _fecha;
  late String _categoria;
  bool _saving = false;

  bool get _isEditing => widget.gastoVariable != null;

  @override
  void initState() {
    super.initState();
    final g = widget.gastoVariable;
    _descCtrl = TextEditingController(text: g?.descripcion ?? '');
    _montoCtrl = TextEditingController(
      text: g != null ? g.monto.toStringAsFixed(2) : '',
    );
    _notasCtrl = TextEditingController(text: g?.notas ?? '');
    _fecha = g?.fecha ?? DateTime.now();
    _categoria = g?.categoria ?? 'imprevisto';
  }

  @override
  void dispose() {
    _descCtrl.dispose();
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

    final dao = ref.read(appDatabaseProvider).gastosVariablesDao;
    final desc = _descCtrl.text.trim();
    final monto = double.parse(_montoCtrl.text.trim().replaceAll(',', '.'));
    final notas = _notasCtrl.text.trim();

    try {
      if (_isEditing) {
        await dao.updateGastoVariable(GastosVariablesCompanion(
          id: Value(widget.gastoVariable!.id),
          descripcion: Value(desc),
          monto: Value(monto),
          fecha: Value(_fecha),
          mes: Value(_fecha.month),
          anio: Value(_fecha.year),
          categoria: Value(_categoria),
          notas: Value(notas.isEmpty ? null : notas),
        ));
      } else {
        await dao.insertGastoVariable(GastosVariablesCompanion(
          descripcion: Value(desc),
          monto: Value(monto),
          fecha: Value(_fecha),
          mes: Value(_fecha.month),
          anio: Value(_fecha.year),
          categoria: Value(_categoria),
          notas: Value(notas.isEmpty ? null : notas),
        ));
      }
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? context.l10n.gastoVariableActualizado
                : context.l10n.gastoVariableAgregado),
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
              _isEditing
                  ? l10n.editarGastoVariable
                  : l10n.agregarGastoVariable,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            // Descripción
            TextFormField(
              controller: _descCtrl,
              decoration: InputDecoration(
                labelText: l10n.descripcion,
                prefixIcon: const Icon(Icons.edit_outlined),
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
            // Categoría
            DropdownButtonFormField<String>(
              // ignore: deprecated_member_use
              value: _categoria,
              decoration: InputDecoration(
                labelText: l10n.categoria,
                prefixIcon: Icon(categoriaVariableIcon(_categoria)),
              ),
              items: kCategoriasVariables
                  .map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(categoriaVariableLabel(context, cat)),
                      ))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _categoria = v);
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
