import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: AppColors.white,
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.black),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => Navigator.of(context).maybePop(),
          child: const Padding(
            padding: EdgeInsets.all(AppSpacing.sm),
            child: Text('←', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
