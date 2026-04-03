import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/configuracion_providers.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/extensions.dart';

/// Shows the onboarding sheet imperatively.
/// Call from DashboardScreen when [ConfiguracionData.estaConfigurado] is false.
Future<void> showOnboardingBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    builder: (_) => const OnboardingBottomSheet(),
  );
}

class OnboardingBottomSheet extends ConsumerStatefulWidget {
  const OnboardingBottomSheet({super.key});

  @override
  ConsumerState<OnboardingBottomSheet> createState() =>
      _OnboardingBottomSheetState();
}

class _OnboardingBottomSheetState
    extends ConsumerState<OnboardingBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  bool _saving = false;

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
            moneda: AppConstants.defaultMoneda,
            simbolo: AppConstants.defaultSimbolo,
            presupuestoDelivery: AppConstants.defaultPresupuestoDelivery,
          );
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
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
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                context.l10n.bienvenido,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.configuraTuPerfil,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nombreCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: context.l10n.tuNombreRequerido,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? context.l10n.campoRequerido
                    : null,
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
                      : Text(context.l10n.comenzar),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
