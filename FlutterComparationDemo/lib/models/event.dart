import 'game.dart';

class GameEventPreview {
  final String id;
  final String name;
  final String? logoImageId;
  final String startTime;

  const GameEventPreview({
    required this.id,
    required this.name,
    required this.logoImageId,
    required this.startTime,
  });

  factory GameEventPreview.fromJson(Map<String, dynamic> json) {
    final logo = json['event_logo'] as Map<String, dynamic>?;
    return GameEventPreview(
      id: json['id'].toString(),
      name: json['name'] as String? ?? 'Unknown',
      logoImageId: logo?['image_id'] as String?,
      startTime: json['start_time'].toString(),
    );
  }

  bool get isFuture {
    final timestamp = int.tryParse(startTime) ?? 0;
    return timestamp > DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }
}

class GameEventDetail extends GameEventPreview {
  final String? description;
  final List<GamePreview> games;

  const GameEventDetail({
    required super.id,
    required super.name,
    required super.logoImageId,
    required super.startTime,
    this.description,
    this.games = const [],
  });

  factory GameEventDetail.fromJson(Map<String, dynamic> json) => GameEventDetail(
        id: json['id'].toString(),
        name: json['name'] as String? ?? 'Unknown',
        logoImageId:
            (json['event_logo'] as Map<String, dynamic>?)?['image_id'] as String?,
        startTime: json['start_time'].toString(),
        description: json['description'] as String?,
        games: (json['games'] as List<dynamic>? ?? [])
            .map((g) => GamePreview.fromJson(g as Map<String, dynamic>))
            .toList(),
      );
}

class SearchResult {
  final String id;
  final GamePreview game;

  const SearchResult({required this.id, required this.game});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final gameJson = Map<String, dynamic>.from(
      json['game'] as Map<String, dynamic>? ?? {},
    );
    if (gameJson['id'] == null && json['id'] != null) {
      gameJson['id'] = json['id'];
    }
    return SearchResult(
      id: json['id'].toString(),
      game: GamePreview.fromJson(gameJson),
    );
  }
}
