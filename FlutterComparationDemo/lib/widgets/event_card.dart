import 'package:flutter/material.dart';

import '../models/event.dart';
import '../theme/app_theme.dart';
import '../utils/date_utils.dart';
import 'date_item.dart';
import 'remote_image.dart';

class EventCard extends StatelessWidget {
  final GameEventPreview event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final timestamp = int.tryParse(event.startTime) ?? 0;
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final formattedDate = formatEventDate(date);

    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.black),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: event.isFuture
            ? null
            : () => Navigator.of(context).pushNamed(
                  '/game-event',
                  arguments: event.id,
                ),
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RemoteImage(
                  imageId: event.logoImageId,
                  recyclingKey:
                      'event-${event.id}-${event.logoImageId ?? 'no-logo'}',
                  aspectRatio: 16 / 9,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  event.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    DateItem(date: formattedDate),
                    if (event.isFuture) ...[
                      const SizedBox(width: AppSpacing.sm),
                      const Text(
                        'Upcoming',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
