import 'package:flutter/material.dart';

import '../models/game.dart';
import '../theme/app_theme.dart';
import 'remote_image.dart';

class GameCard extends StatelessWidget {
  final GamePreview game;
  final double width;

  const GameCard({
    super.key,
    required this.game,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.black),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: game.hasValidId
            ? () => Navigator.of(context).pushNamed(
                  '/game-details',
                  arguments: game.id,
                )
            : null,
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RemoteImage(
                  imageId: game.coverImageId,
                  recyclingKey: 'game-${game.id}-${game.coverImageId ?? 'no-cover'}',
                  aspectRatio: 3 / 4,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  game.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
