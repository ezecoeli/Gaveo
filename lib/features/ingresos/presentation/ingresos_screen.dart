import 'package:flutter/material.dart';

import '../../../core/utils/extensions.dart';

class IngresosScreen extends StatelessWidget {
  const IngresosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.ingresos)),
      body: Center(child: Text('${context.l10n.ingresos} — ${context.l10n.proximamente}')),
    );
  }
}
