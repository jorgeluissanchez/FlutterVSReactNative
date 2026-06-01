class Comment {
  final String id;
  final String gameId;
  final String author;
  final String text;
  final int createdAt;
  final int? updatedAt;

  const Comment({
    required this.id,
    required this.gameId,
    required this.author,
    required this.text,
    required this.createdAt,
    this.updatedAt,
  });

  Comment copyWith({
    String? author,
    String? text,
    int? updatedAt,
  }) {
    return Comment(
      id: id,
      gameId: gameId,
      author: author ?? this.author,
      text: text ?? this.text,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
