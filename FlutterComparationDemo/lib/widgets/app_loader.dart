import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      ),
    );
  }
}
