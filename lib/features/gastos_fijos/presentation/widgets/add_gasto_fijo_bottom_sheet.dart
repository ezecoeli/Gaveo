import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/utils/extensions.dart';

// ── Categorías disponibles ────────────────────────────────────────────────────

const List<String> kCategorias = [
  'general',
  'servicios',
  'alquiler',
  'internet',
  'seguro',
  'salud',
  'educacion',
  'suscripciones',
];

IconData categoriaIcon(String categoria) => switch (categoria) {
      'servicios' => Icons.flash_on_outlined,
      'alquiler' => Icons.home_outlined,
      'internet' => Icons.wifi_outlined,
      'seguro' => Icons.shield_outlined,
      'salud' => Icons.health_and_safety_outlined,
      'educacion' => Icons.school_outlined,
      'suscripciones' => Icons.subscriptions_outlined,
      _ => Icons.receipt_long_outlined,
    };

String categoriaLabel(BuildContext context, String categoria) {
  final l = context.l10n;
  return switch (categoria) {
    'servicios' => l.catServicios,
    'alquiler' => l.catAlquiler,
    'internet' => l.catInternet,
    'seguro' => l.catSeguro,
    'salud' => l.catSalud,
    'educacion' => l.catEducacion,
    'suscripciones' => l.catSuscripciones,
    _ => l.catGeneral,
  };
}

// ── Bottom sheet ──────────────────────────────────────────────────────────────

/// Pass [gastoFijo] to pre-fill for editing; null for add mode.
Future<void> showAddGastoFijoBottomSheet(
  BuildContext context,
  WidgetRef ref, {
  GastosFijo? gastoFijo,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _AddGastoFijoBottomSheet(gastoFijo: gastoFijo),
  );
}

class _AddGastoFijoBottomSheet extends ConsumerStatefulWidget {
  const _AddGastoFijoBottomSheet({this.gastoFijo});

  final GastosFijo? gastoFijo;

  @override
  ConsumerState<_AddGastoFijoBottomSheet> createState() =>
      _AddGastoFijoBottomSheetState();
}

class _AddGastoFijoBottomSheetState
    extends ConsumerState<_AddGastoFijoBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _montoCtrl;
  late final TextEditingController _diaCtrl;
  late final TextEditingController _notasCtrl;
  late String _categoria;
  bool _saving = false;

  bool get _isEditing => widget.gastoFijo != null;

  @override
  void initState() {
    super.initState();
    final g = widget.gastoFijo;
    _nombreCtrl = TextEditingController(text: g?.nombre ?? '');
    _montoCtrl = TextEditingController(
      text: g != null ? g.monto.toStringAsFixed(2) : '',
    );
    // diaVencimiento es nullable: 0 o null = sin fecha
    final dia = g?.diaVencimiento;
    _diaCtrl = TextEditingController(
      text: (dia != null && dia > 0) ? dia.toString() : '',
    );
    _notasCtrl = TextEditingController(text: g?.notas ?? '');
    _categoria = g?.categoria ?? 'general';
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _montoCtrl.dispose();
    _diaCtrl.dispose();
    _notasCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final dao = ref.read(appDatabaseProvider).gastosFijosDao;
    final nombre = _nombreCtrl.text.trim();
    final monto = double.parse(_montoCtrl.text.trim().replaceAll(',', '.'));
    final diaText = _diaCtrl.text.trim();
    final dia = diaText.isEmpty ? null : int.parse(diaText);
    final notas = _notasCtrl.text.trim();

    try {
      if (_isEditing) {
        await dao.updateGastoFijo(GastosFijosCompanion(
          id: Value(widget.gastoFijo!.id),
          nombre: Value(nombre),
          monto: Value(monto),
          diaVencimiento: Value(dia),
          categoria: Value(_categoria),
          notas: Value(notas.isEmpty ? null : notas),
          activo: const Value(true),
        ));
      } else {
        await dao.insertGastoFijo(GastosFijosCompanion(
          nombre: Value(nombre),
          monto: Value(monto),
          diaVencimiento: Value(dia),
          categoria: Value(_categoria),
          notas: Value(notas.isEmpty ? null : notas),
        ));
      }
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? context.l10n.gastoActualizado
                : context.l10n.gastoAgregado),
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
        child: SingleChildScrollView(
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
              _isEditing ? l10n.editarGastoFijo : l10n.agregarGastoFijo,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            // Nombre
            TextFormField(
              controller: _nombreCtrl,
              decoration: InputDecoration(
                labelText: l10n.nombreDelGasto,
                prefixIcon: const Icon(Icons.receipt_long_outlined),
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
                final n =
                    double.tryParse(v.trim().replaceAll(',', '.'));
                if (n == null || n <= 0) return l10n.montoInvalido;
                return null;
              },
            ),
            const SizedBox(height: 12),
            // Día de vencimiento (opcional)
            TextFormField(
              controller: _diaCtrl,
              decoration: InputDecoration(
                labelText: l10n.diaVencimientoOpcional,
                prefixIcon: const Icon(Icons.calendar_today_outlined),
                helperText: l10n.sinFechaVencimiento,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 2,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null; // opcional
                final d = int.tryParse(v.trim());
                if (d == null || d < 1 || d > 31) return l10n.diaInvalido;
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
                prefixIcon:
                    Icon(categoriaIcon(_categoria)),
              ),
              items: kCategorias
                  .map((cat) => DropdownMenuItem(
                        value: cat,
                        child:
                            Text(categoriaLabel(context, cat)),
                      ))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _categoria = v);
              },
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
            // Botón guardar
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
      ),
    );
  }
}
