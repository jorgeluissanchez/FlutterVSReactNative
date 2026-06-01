import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comments_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/back_button_widget.dart';

class CommentFormScreen extends StatefulWidget {
  final String gameId;
  final String? commentId;

  const CommentFormScreen({
    super.key,
    required this.gameId,
    this.commentId,
  });

  @override
  State<CommentFormScreen> createState() => _CommentFormScreenState();
}

class _CommentFormScreenState extends State<CommentFormScreen> {
  final _authorController = TextEditingController();
  final _textController = TextEditingController();
  var _didLoadComment = false;

  bool get _isEditing => widget.commentId != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didLoadComment || widget.commentId == null) return;

    _didLoadComment = true;
    final comment =
        context.read<CommentsProvider>().getCommentById(widget.commentId!);
    if (comment != null) {
      _authorController.text = comment.author;
      _textController.text = comment.text;
    }
  }

  @override
  void dispose() {
    _authorController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final author = _authorController.text.trim();
    final text = _textController.text.trim();

    if (author.isEmpty || text.isEmpty) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Campos requeridos'),
          content: const Text('Autor y comentario son obligatorios.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final provider = context.read<CommentsProvider>();
    if (_isEditing && widget.commentId != null) {
      provider.updateComment(widget.commentId!, author, text);
    } else {
      provider.createComment(widget.gameId, author, text);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const BackButtonWidget(),
            const SizedBox(height: AppSpacing.lg),
            Text(
              _isEditing ? 'Editar comentario' : 'Nuevo comentario',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Los comentarios se guardan solo en memoria (CRUD simulado).',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text(
              'Autor',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                hintText: 'Tu nombre',
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.black),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text(
              'Comentario',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Escribe tu comentario...',
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.black),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Material(
              color: AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: AppColors.black),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: _handleSubmit,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Center(
                    child: Text(
                      _isEditing ? 'Guardar cambios' : 'Crear comentario',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
