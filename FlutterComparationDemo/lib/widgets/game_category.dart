import 'package:flutter/material.dart';

import '../models/fetch_result.dart';
import '../models/game.dart';
import '../services/igdb_service.dart';
import '../theme/app_theme.dart';
import 'app_loader.dart';
import 'game_list.dart';

class GameCategory extends StatefulWidget {
  final GameCategoryConfig config;

  const GameCategory({super.key, required this.config});

  @override
  State<GameCategory> createState() => _GameCategoryState();
}

class _GameCategoryState extends State<GameCategory> {
  late Future<FetchResult<List<GamePreview>>> _future;

  @override
  void initState() {
    super.initState();
    _future = IgdbService.instance.fetchGamesByQuery(widget.config.query);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.config.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.lg),
          FutureBuilder<FetchResult<List<GamePreview>>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AppLoader();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              final games = snapshot.data?.data ?? [];
              return GameList(games: games);
            },
          ),
        ],
      ),
    );
  }
}
