import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/utils/extensions.dart';

// Emojis sugeridos para metas de ahorro
const List<String> kSuggestedEmojis = [
  '💰', '🏠', '🚗', '✈️', '📱', '💻', '🎓', '🏥',
  '👶', '🐾', '🎁', '🏖️', '⛽', '🛒', '💍', '🎮',
];

Future<void> showAddAhorroBottomSheet(
  BuildContext context,
  WidgetRef ref, {
  AhorrosMeta? ahorro,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _AddAhorroBottomSheet(ahorro: ahorro),
  );
}

class _AddAhorroBottomSheet extends ConsumerStatefulWidget {
  const _AddAhorroBottomSheet({this.ahorro});

  final AhorrosMeta? ahorro;

  @override
  ConsumerState<_AddAhorroBottomSheet> createState() =>
      _AddAhorroBottomSheetState();
}

class _AddAhorroBottomSheetState
    extends ConsumerState<_AddAhorroBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _montoMensualCtrl;
  late final TextEditingController _montoObjetivoCtrl;
  late String _emoji;
  late bool _activo;
  bool _saving = false;

  bool get _isEditing => widget.ahorro != null;

  @override
  void initState() {
    super.initState();
    final a = widget.ahorro;
    _nombreCtrl = TextEditingController(text: a?.nombre ?? '');
    _montoMensualCtrl = TextEditingController(
      text: a != null ? a.montoMensual.toStringAsFixed(2) : '',
    );
    _montoObjetivoCtrl = TextEditingController(
      text: a?.montoObjetivo != null
          ? a!.montoObjetivo!.toStringAsFixed(2)
          : '',
    );
    _emoji = a?.emoji ?? '💰';
    _activo = a?.activo ?? true;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _montoMensualCtrl.dispose();
    _montoObjetivoCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final dao = ref.read(appDatabaseProvider).ahorrosDao;
    final nombre = _nombreCtrl.text.trim();
    final montoMensual =
        double.parse(_montoMensualCtrl.text.trim().replaceAll(',', '.'));
    final montoObjetivo = _montoObjetivoCtrl.text.trim().isEmpty
        ? null
        : double.tryParse(
            _montoObjetivoCtrl.text.trim().replaceAll(',', '.'));

    try {
      if (_isEditing) {
        await dao.updateAhorro(AhorrosMetasCompanion(
          id: Value(widget.ahorro!.id),
          nombre: Value(nombre),
          montoMensual: Value(montoMensual),
          montoObjetivo: Value(montoObjetivo),
          activo: Value(_activo),
          emoji: Value(_emoji),
        ));
      } else {
        await dao.insertAhorro(AhorrosMetasCompanion(
          nombre: Value(nombre),
          montoMensual: Value(montoMensual),
          montoObjetivo: Value(montoObjetivo),
          activo: Value(_activo),
          emoji: Value(_emoji),
        ));
      }
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? context.l10n.metaActualizada
                : context.l10n.metaAgregada),
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
                _isEditing ? l10n.editarMeta : l10n.agregarMeta,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              // Emoji selector
              Text(l10n.emojiMeta,
                  style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: kSuggestedEmojis.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final e = kSuggestedEmojis[i];
                    final selected = _emoji == e;
                    return GestureDetector(
                      onTap: () => setState(() => _emoji = e),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: selected
                              ? theme.colorScheme.primaryContainer
                              : theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                          border: selected
                              ? Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2)
                              : null,
                        ),
                        child: Center(
                          child: Text(e,
                              style: const TextStyle(fontSize: 22)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Nombre
              TextFormField(
                controller: _nombreCtrl,
                decoration: InputDecoration(
                  labelText: l10n.nombreMeta,
                  prefixIcon: const Icon(Icons.label_outlined),
                ),
                textCapitalization: TextCapitalization.sentences,
                maxLength: 100,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.campoRequerido
                    : null,
              ),
              const SizedBox(height: 12),
              // Monto mensual
              TextFormField(
                controller: _montoMensualCtrl,
                decoration: InputDecoration(
                  labelText: l10n.montoMensual,
                  prefixIcon: const Icon(Icons.savings_outlined),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                ],
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return l10n.campoRequerido;
                  }
                  final n = double.tryParse(v.trim().replaceAll(',', '.'));
                  if (n == null || n <= 0) return l10n.montoInvalido;
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Monto objetivo (opcional)
              TextFormField(
                controller: _montoObjetivoCtrl,
                decoration: InputDecoration(
                  labelText: l10n.montoObjetivo,
                  prefixIcon: const Icon(Icons.flag_outlined),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                ],
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final n = double.tryParse(v.trim().replaceAll(',', '.'));
                  if (n == null || n <= 0) return l10n.montoInvalido;
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Activo toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(_activo ? l10n.activo : l10n.inactivo),
                value: _activo,
                onChanged: (v) => setState(() => _activo = v),
              ),
              const SizedBox(height: 12),
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
