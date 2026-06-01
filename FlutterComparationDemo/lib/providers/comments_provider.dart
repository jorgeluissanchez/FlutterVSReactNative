import 'package:flutter/foundation.dart';

import '../models/comment.dart';

class CommentsProvider extends ChangeNotifier {
  final List<Comment> _comments = [];

  List<Comment> get comments => List.unmodifiable(_comments);

  List<Comment> getCommentsByGameId(String gameId) =>
      _comments.where((c) => c.gameId == gameId).toList();

  Comment? getCommentById(String id) {
    try {
      return _comments.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  void createComment(String gameId, String author, String text) {
    _comments.insert(
      0,
      Comment(
        id: _createId(),
        gameId: gameId,
        author: author,
        text: text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
    notifyListeners();
  }

  void updateComment(String id, String author, String text) {
    final index = _comments.indexWhere((c) => c.id == id);
    if (index == -1) return;

    _comments[index] = _comments[index].copyWith(
      author: author,
      text: text,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    notifyListeners();
  }

  void deleteComment(String id) {
    _comments.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  String _createId() =>
      '${DateTime.now().millisecondsSinceEpoch}-${DateTime.now().microsecond}';
}
