import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/date_utils.dart';

part 'dashboard_providers.g.dart';

// ── Mes seleccionado (estado global de sesión) ────────────────────────────────

@riverpod
class SelectedMonth extends _$SelectedMonth {
  @override
  ({int mes, int anio}) build() {
    final now = DateTime.now();
    return (mes: now.month, anio: now.year);
  }

  void goToPreviousMonth() {
    final prev = AppDateUtils.previousMonth(state.mes, state.anio);
    state = prev;
  }

  void goToNextMonth() {
    if (AppDateUtils.canGoToNextMonth(state.mes, state.anio)) {
      final next = AppDateUtils.nextMonth(state.mes, state.anio);
      state = next;
    }
  }

  void setMonth(int mes, int anio) {
    state = (mes: mes, anio: anio);
  }
}
