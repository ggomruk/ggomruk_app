import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/theme_cubit.dart';
import 'top_app_bar.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return TopAppBar(
      customTitle: 'User',
      actions: [
        BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, theme) {
            return Switch(
              value: theme.brightness == Brightness.dark,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleTheme();
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}