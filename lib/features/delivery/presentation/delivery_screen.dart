import 'package:flutter/material.dart';

import '../../../core/utils/extensions.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.delivery)),
      body: Center(child: Text('${context.l10n.delivery} — ${context.l10n.proximamente}')),
    );
  }
}
