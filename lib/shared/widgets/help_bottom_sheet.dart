import 'package:flutter/material.dart';

class HelpItem {
  final IconData icon;
  final String text;

  const HelpItem({required this.icon, required this.text});
}

void showHelpBottomSheet(
  BuildContext context, {
  required String title,
  required List<HelpItem> items,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => _HelpBottomSheet(title: title, items: items),
  );
}

class _HelpBottomSheet extends StatelessWidget {
  const _HelpBottomSheet({required this.title, required this.items});

  final String title;
  final List<HelpItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
        ),
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
              Row(
                children: [
                  Icon(
                    Icons.help_outline_rounded,
                    color: theme.colorScheme.primary,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(title, style: theme.textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 20),
              ...List.generate(items.length, (i) {
                return Column(
                  children: [
                    if (i > 0)
                      Divider(
                        height: 24,
                        color: theme.colorScheme.outlineVariant
                            .withValues(alpha: 0.5),
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Icon(
                            items[i].icon,
                            size: 20,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            items[i].text,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
