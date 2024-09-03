import 'package:go_router/go_router.dart';

import '../main/main_screen.dart';
import '../pages/backtest/backtest_page.dart';
import '../pages/splash/splash_page.dart';
import 'route_path.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutePath.main,
      name: 'main',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: RoutePath.backtest,
      name: 'backtest',
      builder: (context, state) => const BacktestPage(),
    ),
  ],
  initialLocation: RoutePath.main,
);
