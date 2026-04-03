import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/extensions.dart';
import '../features/ahorros/presentation/ahorros_screen.dart';
import '../features/configuracion/presentation/configuracion_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/delivery/presentation/delivery_screen.dart';
import '../features/gastos_fijos/presentation/gastos_fijos_screen.dart';
import '../features/gastos_variables/presentation/gastos_variables_screen.dart';
import '../features/historial/presentation/historial_screen.dart';
import '../features/ingresos/presentation/ingresos_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/gastos-fijos',
          builder: (_, __) => const GastosFijosScreen(),
        ),
        GoRoute(
          path: '/gastos-variables',
          builder: (_, __) => const GastosVariablesScreen(),
        ),
        GoRoute(
          path: '/delivery',
          builder: (_, __) => const DeliveryScreen(),
        ),
        GoRoute(
          path: '/ahorros',
          builder: (_, __) => const AhorrosScreen(),
        ),
      ],
    ),
    // Rutas fuera del shell (sin nav bar)
    GoRoute(
      path: '/ingresos',
      builder: (_, __) => const IngresosScreen(),
    ),
    GoRoute(
      path: '/configuracion',
      builder: (_, __) => const ConfiguracionScreen(),
    ),
    GoRoute(
      path: '/historial',
      builder: (_, __) => const HistorialScreen(),
    ),
  ],
);

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const _routes = [
    '/',
    '/gastos-fijos',
    '/gastos-variables',
    '/delivery',
    '/ahorros',
  ];

  int _locationToIndex(String location) {
    for (int i = 0; i < _routes.length; i++) {
      if (location.startsWith(_routes[i]) && _routes[i] != '/') return i;
      if (_routes[i] == '/' && location == '/') return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    final destinations = [
      NavigationDestination(
        icon: const Icon(Icons.dashboard_outlined),
        selectedIcon: const Icon(Icons.dashboard),
        label: l10n.navInicio,
      ),
      NavigationDestination(
        icon: const Icon(Icons.receipt_long_outlined),
        selectedIcon: const Icon(Icons.receipt_long),
        label: l10n.navFijos,
      ),
      NavigationDestination(
        icon: const Icon(Icons.shopping_bag_outlined),
        selectedIcon: const Icon(Icons.shopping_bag),
        label: l10n.navVariables,
      ),
      NavigationDestination(
        icon: const Icon(Icons.delivery_dining_outlined),
        selectedIcon: const Icon(Icons.delivery_dining),
        label: l10n.navDelivery,
      ),
      NavigationDestination(
        icon: const Icon(Icons.savings_outlined),
        selectedIcon: const Icon(Icons.savings),
        label: l10n.navAhorros,
      ),
    ];

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => context.go(_routes[index]),
        destinations: destinations,
      ),
    );
  }
}
