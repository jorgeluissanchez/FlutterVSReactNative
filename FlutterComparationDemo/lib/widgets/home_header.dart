import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'GamesExplorer Flutter',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/search'),
            icon: const Text('🔍', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
