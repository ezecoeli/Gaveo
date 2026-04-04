import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'configuracion_providers.dart';

part 'locale_provider.g.dart';

@Riverpod(keepAlive: true)
Locale appLocale(Ref ref) {
  final config = ref.watch(configuracionNotifierProvider);
  return config.maybeWhen(
    data: (c) => Locale(c.idioma),
    orElse: () => const Locale('es'),
  );
}

@Riverpod(keepAlive: true)
ThemeMode appThemeMode(Ref ref) {
  final config = ref.watch(configuracionNotifierProvider);
  return config.maybeWhen(
    data: (c) {
      switch (c.tema) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        default:
          return ThemeMode.system;
      }
    },
    orElse: () => ThemeMode.system,
  );
}
