import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/configuracion_providers.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/constants/currencies.dart';
import '../../../core/utils/extensions.dart';
import 'widgets/currency_picker_sheet.dart';

class ConfiguracionScreen extends ConsumerWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(configuracionNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.configTitle)),
      body: configAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline,
                  size: 48, color: AppColors.expense),
              const SizedBox(height: 16),
              Text(context.l10n.errorCargarConfig,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () =>
                    ref.invalidate(configuracionNotifierProvider),
                child: Text(context.l10n.reintentar),
              ),
            ],
          ),
        ),
        data: (config) => _ConfiguracionForm(config: config),
      ),
    );
  }
}

class _ConfiguracionForm extends ConsumerStatefulWidget {
  const _ConfiguracionForm({required this.config});

  final ConfiguracionData config;

  @override
  ConsumerState<_ConfiguracionForm> createState() =>
      _ConfiguracionFormState();
}

class _ConfiguracionFormState extends ConsumerState<_ConfiguracionForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl;
  late CurrencyInfo _currency;
  late String _idioma;
  late String _tema;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nombreCtrl =
        TextEditingController(text: widget.config.nombreUsuario);
    _currency = currencyByCode(widget.config.moneda) ??
        kCurrencies.first;
    _idioma = widget.config.idioma;
    _tema = widget.config.tema;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref.read(configuracionNotifierProvider.notifier).guardar(
            nombreUsuario: _nombreCtrl.text.trim(),
            moneda: _currency.code,
            simbolo: _currency.symbol,
            presupuestoDelivery: widget.config.presupuestoDelivery,
            idioma: _idioma,
            tema: _tema,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.configGuardada)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.perfil, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nombreCtrl,
              decoration: InputDecoration(
                labelText: l10n.tuNombre,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.campoRequerido : null,
            ),
            const SizedBox(height: 24),
            Text(l10n.moneda, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            _CurrencyTile(
              currency: _currency,
              onTap: () async {
                final picked = await showCurrencyPicker(
                  context,
                  currentCode: _currency.code,
                );
                if (picked != null) setState(() => _currency = picked);
              },
            ),
            const SizedBox(height: 24),
            Text(l10n.idioma, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<String>(
                expandedInsets: EdgeInsets.zero,
                segments: const [
                  ButtonSegment(
                    value: 'es',
                    label: SizedBox(
                      width: 72,
                      child: Text('Español',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  ButtonSegment(
                    value: 'en',
                    label: SizedBox(
                      width: 72,
                      child: Text('English',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
                selected: {_idioma},
                onSelectionChanged: (s) =>
                    setState(() => _idioma = s.first),
              ),
            ),
            const SizedBox(height: 24),
            Text(l10n.tema, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'light',
                  label: Text(l10n.temaClaro),
                  icon: const Icon(Icons.light_mode_outlined),
                ),
                ButtonSegment(
                  value: 'dark',
                  label: Text(l10n.temaOscuro),
                  icon: const Icon(Icons.dark_mode_outlined),
                ),
              ],
              selected: {_tema},
              onSelectionChanged: (s) => setState(() => _tema = s.first),
            ),
            const SizedBox(height: 32),
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
      ),
    );
  }
}

class _CurrencyTile extends StatelessWidget {
  const _CurrencyTile({required this.currency, required this.onTap});

  final CurrencyInfo currency;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: const InputDecoration(),
        child: Row(
          children: [
            Text(currency.flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currency.localizedName(locale)),
                  Text(
                    '${currency.code} · ${currency.symbol}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
