import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension DoubleExtensions on double {
  bool get isPositive => this > 0;
  bool get isZero => this == 0;

  double get asPositive => abs();
}

extension ListExtensions<T extends num> on Iterable<T> {
  T get sum => fold(0 as T, (a, b) => (a + b) as T);
}
