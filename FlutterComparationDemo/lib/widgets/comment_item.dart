import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/comment.dart';
import '../providers/comments_provider.dart';
import '../theme/app_theme.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  comment.author,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  '/comment-form',
                  arguments: {
                    'gameId': comment.gameId,
                    'commentId': comment.id,
                  },
                ),
                child: const Text(
                  'Editar',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _confirmDelete(context),
                child: const Text(
                  'Eliminar',
                  style: TextStyle(
                    color: AppColors.delete,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            comment.text,
            style: const TextStyle(fontSize: 15, height: 1.4),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar comentario'),
        content: const Text('¿Seguro que deseas eliminar este comentario?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Eliminar',
              style: TextStyle(color: AppColors.delete),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<CommentsProvider>().deleteComment(comment.id);
    }
  }
}
