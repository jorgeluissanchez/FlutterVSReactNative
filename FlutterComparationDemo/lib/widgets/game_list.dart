import 'package:flutter/material.dart';

import '../models/game.dart';
import '../theme/app_theme.dart';
import 'game_card.dart';

class GameList extends StatelessWidget {
  final List<GamePreview> games;

  const GameList({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < games.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpacing.md),
            GameCard(game: games[i]),
          ],
          const SizedBox(width: AppSpacing.md),
        ],
      ),
    );
  }
}
