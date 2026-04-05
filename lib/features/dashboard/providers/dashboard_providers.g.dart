// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedMonthHash() => r'7f0b546ea2eb11ae20744a058d82526ea56a786c';

/// See also [SelectedMonth].
@ProviderFor(SelectedMonth)
final selectedMonthProvider =
    AutoDisposeNotifierProvider<SelectedMonth, ({int mes, int anio})>.internal(
  SelectedMonth.new,
  name: r'selectedMonthProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedMonthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedMonth = AutoDisposeNotifier<({int mes, int anio})>;
String _$dashboardNotifierHash() => r'5b4d75afa614f7259e7acf47009ade4ea4dccf1d';

/// See also [DashboardNotifier].
@ProviderFor(DashboardNotifier)
final dashboardNotifierProvider = AutoDisposeAsyncNotifierProvider<
    DashboardNotifier, DashboardSummary>.internal(
  DashboardNotifier.new,
  name: r'dashboardNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DashboardNotifier = AutoDisposeAsyncNotifier<DashboardSummary>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
