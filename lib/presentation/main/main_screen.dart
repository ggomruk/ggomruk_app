import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/backtest/backtest_page.dart';
import '../pages/trade/trade_page.dart';
import '../pages/history/history_page.dart';
import '../pages/user/user_page.dart';
import 'component/top_app_bar.dart';
import 'component/user_app_bar.dart';
import 'cubit/bottom_navigation_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<BottomNavCubit, int>(
        builder: (context, currentIndex) {
          return IndexedStack(
            index: currentIndex,
            children: const [
              BacktestPage(),
              TradePage(),
              HistoryPage(),
              UserPage(),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
        builder: (context, currentIndex) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined),
                label: 'Backtest',
                activeIcon: Icon(Icons.analytics),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.candlestick_chart_outlined),
                label: 'Trade',
                activeIcon: Icon(Icons.candlestick_chart),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
                activeIcon: Icon(Icons.history_outlined),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'User',
                activeIcon: Icon(Icons.person),
              ),
            ],
            currentIndex: currentIndex,
            onTap: (index) => context.read<BottomNavCubit>().changeIndex(index),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.5),
            selectedIconTheme: IconThemeData(color: theme.colorScheme.primary),
            unselectedIconTheme: IconThemeData(color: theme.colorScheme.onSurface.withOpacity(0.5)),
            backgroundColor: theme.colorScheme.surface,
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final currentNav = context.watch<BottomNavCubit>().currentNav;
    switch (currentNav) {
      case BottomNav.user:
        return UserAppBar();
      default:
        return TopAppBar();
    }
  }
}