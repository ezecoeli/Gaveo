import 'package:flutter/material.dart';

import '../../../core/utils/extensions.dart';

class AhorrosScreen extends StatelessWidget {
  const AhorrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.ahorros)),
      body: Center(child: Text('${context.l10n.ahorros} — ${context.l10n.proximamente}')),
    );
  }
}
