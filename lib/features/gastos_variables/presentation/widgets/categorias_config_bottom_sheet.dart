import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/utils/extensions.dart';
import 'add_gasto_variable_bottom_sheet.dart'
    show kCategoriasVariables, categoriaVariableIcon, categoriaVariableLabel;

Future<void> showCategoriasConfigBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _CategoriasConfigBottomSheet(),
  );
}

class _CategoriasConfigBottomSheet extends ConsumerStatefulWidget {
  const _CategoriasConfigBottomSheet();

  @override
  ConsumerState<_CategoriasConfigBottomSheet> createState() =>
      _CategoriasConfigBottomSheetState();
}

class _CategoriasConfigBottomSheetState
    extends ConsumerState<_CategoriasConfigBottomSheet> {
  // categoria → (limite controller, mostrarEnInicio)
  late final Map<String, TextEditingController> _limiteCtrlMap;
  late final Map<String, bool> _mostrarMap;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _limiteCtrlMap = {
      for (final cat in kCategoriasVariables)
        cat: TextEditingController(),
    };
    _mostrarMap = {for (final cat in kCategoriasVariables) cat: false};
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    final dao = ref.read(appDatabaseProvider).categoriasVariablesConfigDao;
    final configs = await dao.watchAll().first;
    for (final cfg in configs) {
      if (_limiteCtrlMap.containsKey(cfg.categoria)) {
        _limiteCtrlMap[cfg.categoria]!.text =
            cfg.limite != null ? cfg.limite!.toStringAsFixed(2) : '';
        _mostrarMap[cfg.categoria] = cfg.mostrarEnInicio;
      }
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    for (final ctrl in _limiteCtrlMap.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final dao = ref.read(appDatabaseProvider).categoriasVariablesConfigDao;
    try {
      for (final cat in kCategoriasVariables) {
        final limiteText = _limiteCtrlMap[cat]!.text.trim();
        final limite = limiteText.isEmpty
            ? null
            : double.tryParse(limiteText.replaceAll(',', '.'));
        final mostrar = _mostrarMap[cat] ?? false;

        if (limite == null && !mostrar) {
          // Sin configuración especial → eliminar si existía
          await dao.deleteCategoria(cat);
        } else {
          await dao.upsertCategoria(CategoriasVariablesConfigCompanion(
            categoria: Value(cat),
            limite: Value(limite),
            mostrarEnInicio: Value(mostrar),
          ));
        }
      }
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          // Handle + header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
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
                Text(l10n.configurarCategorias,
                    style: theme.textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  l10n.limiteDesc,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                const Divider(),
              ],
            ),
          ),
          // Lista de categorías
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: kCategoriasVariables.length,
              itemBuilder: (context, i) {
                final cat = kCategoriasVariables[i];
                return _CategoriaConfigTile(
                  categoria: cat,
                  limiteCtrl: _limiteCtrlMap[cat]!,
                  mostrar: _mostrarMap[cat] ?? false,
                  onMostrarChanged: (v) =>
                      setState(() => _mostrarMap[cat] = v),
                );
              },
            ),
          ),
          // Botón guardar
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              MediaQuery.viewInsetsOf(context).bottom + 16,
            ),
            child: SizedBox(
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
          ),
        ],
      ),
    );
  }
}

class _CategoriaConfigTile extends StatelessWidget {
  const _CategoriaConfigTile({
    required this.categoria,
    required this.limiteCtrl,
    required this.mostrar,
    required this.onMostrarChanged,
  });

  final String categoria;
  final TextEditingController limiteCtrl;
  final bool mostrar;
  final ValueChanged<bool> onMostrarChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(categoriaVariableIcon(categoria),
                    size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  categoriaVariableLabel(context, categoria),
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: limiteCtrl,
              decoration: InputDecoration(
                labelText: l10n.limiteOpcional,
                prefixIcon: const Icon(Icons.flag_outlined),
                isDense: true,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
              ],
            ),
            SwitchListTile(
              value: mostrar,
              onChanged: onMostrarChanged,
              title: Text(l10n.mostrarEnInicio,
                  style: theme.textTheme.bodySmall),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}
