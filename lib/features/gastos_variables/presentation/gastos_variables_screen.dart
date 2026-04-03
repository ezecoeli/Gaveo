import 'package:flutter/material.dart';

import '../../../core/utils/extensions.dart';

class GastosVariablesScreen extends StatelessWidget {
  const GastosVariablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.gastosVariables)),
      body: Center(child: Text('${context.l10n.gastosVariables} — ${context.l10n.proximamente}')),
    );
  }
}
