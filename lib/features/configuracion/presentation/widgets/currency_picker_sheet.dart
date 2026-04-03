import 'package:flutter/material.dart';

import '../../../../core/constants/currencies.dart';
import '../../../../core/utils/extensions.dart';

/// Shows a modal bottom sheet to pick a [CurrencyInfo].
/// Returns the selected [CurrencyInfo], or null if dismissed.
Future<CurrencyInfo?> showCurrencyPicker(
  BuildContext context, {
  String? currentCode,
}) {
  return showModalBottomSheet<CurrencyInfo>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _CurrencyPickerSheet(currentCode: currentCode),
  );
}

class _CurrencyPickerSheet extends StatefulWidget {
  const _CurrencyPickerSheet({this.currentCode});

  final String? currentCode;

  @override
  State<_CurrencyPickerSheet> createState() => _CurrencyPickerSheetState();
}

class _CurrencyPickerSheetState extends State<_CurrencyPickerSheet> {
  final _searchCtrl = TextEditingController();
  List<CurrencyInfo> _filtered = kCurrencies;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? kCurrencies
          : kCurrencies
              .where((c) =>
                  c.code.toLowerCase().contains(q) ||
                  c.nameEs.toLowerCase().contains(q) ||
                  c.nameEn.toLowerCase().contains(q) ||
                  c.symbol.toLowerCase().contains(q))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                l10n.seleccionarMoneda,
                style: theme.textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 12),
            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l10n.buscarMoneda,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _searchCtrl.clear(),
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // List
            Expanded(
              child: _filtered.isEmpty
                  ? Center(child: Text(l10n.sinResultados))
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: _filtered.length,
                      itemBuilder: (context, index) {
                        final currency = _filtered[index];
                        final isSelected =
                            currency.code == widget.currentCode;
                        return ListTile(
                          leading: Text(
                            currency.flag,
                            style: const TextStyle(fontSize: 28),
                          ),
                          title: Text(currency.localizedName(locale)),
                          trailing: Text(
                            '${currency.code} · ${currency.symbol}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          selected: isSelected,
                          selectedTileColor:
                              theme.colorScheme.primaryContainer,
                          onTap: () => Navigator.of(context).pop(currency),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
