import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/fetch_result.dart';
import '../services/igdb_service.dart';
import '../theme/app_theme.dart';
import '../utils/date_utils.dart';
import '../widgets/app_loader.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/date_item.dart';
import '../widgets/game_list.dart';
import '../widgets/remote_image.dart';

class GameEventScreen extends StatefulWidget {
  final String eventId;

  const GameEventScreen({super.key, required this.eventId});

  @override
  State<GameEventScreen> createState() => _GameEventScreenState();
}

class _GameEventScreenState extends State<GameEventScreen> {
  late Future<FetchResult<GameEventDetail>> _future;

  @override
  void initState() {
    super.initState();
    _future = IgdbService.instance.fetchGameEvent(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<FetchResult<GameEventDetail>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoader();
            }
            if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Text('Error'),
              );
            }

            final result = snapshot.data!;
            final event = result.data;
            final timestamp = int.tryParse(event.startTime) ?? 0;
            final formattedDate = formatEventDate(
              DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
            );

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
                RemoteImage(
                  imageId: event.logoImageId,
                  recyclingKey:
                      'event-detail-${event.id}-${event.logoImageId ?? 'no-logo'}',
                  aspectRatio: 16 / 9,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  event.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                DateItem(date: formattedDate),
                if (event.description != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    event.description!,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                GameList(games: event.games),
              ],
            );
          },
        ),
      ),
    );
  }
}
