// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historial_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historialMesesHash() => r'b931300cb5769e2f20d47a2906843d286e9647f8';

/// Returns monthly summaries for the last 12 months (newest first).
/// Gastos fijos and ahorros are recurring — same total for every month.
///
/// Copied from [historialMeses].
@ProviderFor(historialMeses)
final historialMesesProvider =
    AutoDisposeFutureProvider<List<HistorialMesData>>.internal(
  historialMeses,
  name: r'historialMesesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$historialMesesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HistorialMesesRef
    = AutoDisposeFutureProviderRef<List<HistorialMesData>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
