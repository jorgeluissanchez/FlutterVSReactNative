import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/game.dart';
import '../theme/app_theme.dart';
import '../widgets/game_category.dart';
import '../widgets/game_events.dart';
import '../widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<GameCategoryConfig> _categories() {
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return [
      GameCategoryConfig(
        id: '1',
        title: 'Most Anticipated',
        query: '''
      fields id, name, cover.image_id, first_release_date, hypes;
      where hypes > 0 & first_release_date > $currentTimestamp;
      sort hypes desc;
      limit 20;''',
      ),
      GameCategoryConfig(
        id: '2',
        title: 'Recently Released',
        query: '''
      fields id, name, cover.image_id, first_release_date, rating, rating_count;
      where first_release_date > ${currentTimestamp - 60 * 60 * 24 * 30 * 3};
      sort rating_count desc;
      limit 20;
      ''',
      ),
      GameCategoryConfig(
        id: '3',
        title: 'Currently Popular',
        query: '''
      fields id, name, cover.image_id, first_release_date, rating, rating_count;
      where first_release_date > ${currentTimestamp - 60 * 60 * 24 * 365}
        & rating_count > 50;
      sort rating_count desc;
      limit 20;
      ''',
      ),
      GameCategoryConfig(
        id: '4',
        title: 'Top 20',
        query: '''
      fields id, name, cover.image_id, rating, rating_count;
      where rating >= 90 & rating_count > 50;
      sort rating_count desc;
      limit 20;
      ''',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final categories = _categories();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
          children: [
            const HomeHeader(),
            if (kIsWeb) ...[
              const SizedBox(height: AppSpacing.lg),
              const _WebPlatformWarning(),
            ],
            const SizedBox(height: AppSpacing.lg),
            const GameEvents(),
            const SizedBox(height: AppSpacing.lg),
            for (final category in categories) ...[
              GameCategory(config: category),
              const SizedBox(height: AppSpacing.lg),
            ],
          ],
        ),
      ),
    );
  }
}

class _WebPlatformWarning extends StatelessWidget {
  const _WebPlatformWarning();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3CD),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.black),
        ),
        child: const Text(
          'Estás en Flutter Web (Chrome/Edge). La API de IGDB no permite '
          'peticiones desde el navegador (CORS), por eso ves "Failed to fetch". '
          'Ejecuta con: flutter run -d windows o conecta un emulador/dispositivo Android.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
      ),
    );
  }
}
