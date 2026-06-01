import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comments_provider.dart';
import '../theme/app_theme.dart';
import 'comment_item.dart';

class CommentsSection extends StatelessWidget {
  final String gameId;

  const CommentsSection({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    final comments = context.watch<CommentsProvider>().getCommentsByGameId(gameId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Comentarios (CRUD local)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Material(
              color: AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: AppColors.black),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => Navigator.of(context).pushNamed(
                  '/comment-form',
                  arguments: {'gameId': gameId},
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Text(
                    '+ Nuevo',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (comments.isEmpty)
          const Text(
            'No hay comentarios. Crea uno para probar el CRUD en memoria.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          )
        else
          ...comments.map(
            (comment) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: CommentItem(comment: comment),
            ),
          ),
      ],
    );
  }
}
