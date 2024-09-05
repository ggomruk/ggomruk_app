import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/custom/custom_theme.dart';
import '../cubit/bottom_navigation_cubit.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final double height;
  final String? customTitle;

  const TopAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.height = kToolbarHeight,
    this.customTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        final currentNav = context.read<BottomNavCubit>().currentNav;
        String title = customTitle ?? _getTitleFromNav(currentNav);

        return AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: CustomTheme.customAppBarStyle.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
          ),
          leading: leading != null
              ? Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: leading,
          )
              : null,
          actions: actions != null
              ? [
            ...actions!,
            const SizedBox(width: 16.0),
          ]
              : null,
          backgroundColor: theme.colorScheme.background,
          foregroundColor: theme.colorScheme.onBackground,
          elevation: 0,
          toolbarHeight: height,
        );
      },
    );
  }

  String _getTitleFromNav(BottomNav nav) {
    switch (nav) {
      case BottomNav.backtest:
        return 'Backtest';
      case BottomNav.trade:
        return 'Trade';
      case BottomNav.history:
        return 'History';
      case BottomNav.user:
        return 'User';
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}