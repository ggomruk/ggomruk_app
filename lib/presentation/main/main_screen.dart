import 'package:flutter/material.dart';
import '../../core/theme/constant/app_colors.dart';
import '../../core/theme/custom/custom_app_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Main Screen',
        backgroundColor: AppColors.primary,
        height: 56.0,
        elevation: 4.0,
      ),
      body: const Center(
        child: Text('Welcome to the Main Screen!'),
      ),
    );
  }
}