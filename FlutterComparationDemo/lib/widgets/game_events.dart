import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/fetch_result.dart';
import '../services/igdb_service.dart';
import '../theme/app_theme.dart';
import 'app_loader.dart';
import 'event_card.dart';

class GameEvents extends StatefulWidget {
  const GameEvents({super.key});

  @override
  State<GameEvents> createState() => _GameEventsState();
}

class _GameEventsState extends State<GameEvents> {
  late Future<FetchResult<List<GameEventPreview>>> _future;

  @override
  void initState() {
    super.initState();
    _future = IgdbService.instance.fetchGameEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Game Events',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.lg),
          FutureBuilder<FetchResult<List<GameEventPreview>>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AppLoader();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              final events = snapshot.data?.data ?? [];
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < events.length; i++) ...[
                      if (i > 0) const SizedBox(width: AppSpacing.md),
                      EventCard(event: events[i]),
                    ],
                    const SizedBox(width: AppSpacing.md),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
