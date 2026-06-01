import 'package:flutter/material.dart';

import '../models/fetch_result.dart';
import '../models/game.dart';
import '../services/igdb_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_loader.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/comments_section.dart';
import '../widgets/date_item.dart';
import '../widgets/game_list.dart';
import '../widgets/remote_image.dart';

class GameDetailsScreen extends StatefulWidget {
  final String gameId;

  const GameDetailsScreen({super.key, required this.gameId});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  late Future<FetchResult<GameDetail>> _future;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _future = IgdbService.instance.fetchGame(widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<FetchResult<GameDetail>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoader();
            }
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text('Error: ${snapshot.error}'),
              );
            }

            final result = snapshot.data!;
            final game = result.data;
            final summary = game.summary ?? '';
            final displaySummary = _expanded || summary.length <= 200
                ? summary
                : '${summary.substring(0, 200)}...';

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                const BackButtonWidget(),
                const SizedBox(height: AppSpacing.lg),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'API: ${result.durationMs} ms',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: RemoteImage(
                      imageId: game.coverImageId,
                      recyclingKey:
                          'cover-${game.id}-${game.coverImageId ?? 'no-cover'}',
                      aspectRatio: 3 / 4,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        game.name,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (game.rating != null) ...[
                      const Text('⭐', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        (game.rating! / 10).toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'By ${game.developer ?? 'Unknown'}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                DateItem(date: game.releaseDateHuman ?? 'TBA'),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  displaySummary,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                if (!_expanded && summary.length > 200)
                  TextButton(
                    onPressed: () => setState(() => _expanded = true),
                    child: const Text(
                      'See More',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.lg),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: game.genres
                      .map((genre) => _TagChip(label: genre.name))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  'Screenshots',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  height: 130,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: game.screenshots.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final screenshot = game.screenshots[index];
                      return SizedBox(
                        width: 230,
                        child: RemoteImage(
                          imageId: screenshot.imageId,
                          recyclingKey:
                              'screenshot-${screenshot.id}-${screenshot.imageId}',
                          aspectRatio: 16 / 9,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  'You can play on',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.lg),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: game.platforms
                      .map((platform) => _TagChip(label: platform.name))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  'You may also like',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.lg),
                GameList(games: game.similarGames),
                const SizedBox(height: AppSpacing.lg),
                CommentsSection(gameId: widget.gameId),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.black),
      ),
      child: Text(label),
    );
  }
}
