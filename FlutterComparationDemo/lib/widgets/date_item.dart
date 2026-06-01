import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DateItem extends StatelessWidget {
  final String date;

  const DateItem({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.black),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📅', style: TextStyle(fontSize: 18)),
          const SizedBox(width: AppSpacing.sm),
          Text(date, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
