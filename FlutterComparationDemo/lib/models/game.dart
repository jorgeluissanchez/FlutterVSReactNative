class GamePreview {
  final String id;
  final String name;
  final String? coverImageId;

  const GamePreview({
    required this.id,
    required this.name,
    this.coverImageId,
  });

  factory GamePreview.fromJson(Map<String, dynamic> json) {
    final cover = json['cover'] as Map<String, dynamic>?;
    final rawId = json['id'];
    return GamePreview(
      id: rawId == null ? '' : rawId.toString(),
      name: json['name'] as String? ?? 'Unknown',
      coverImageId: cover?['image_id'] as String?,
    );
  }

  bool get hasValidId => id.isNotEmpty && id != 'null';
}

class GameDetail extends GamePreview {
  final double? rating;
  final String? summary;
  final String? developer;
  final String? releaseDateHuman;
  final List<Genre> genres;
  final List<Screenshot> screenshots;
  final List<Platform> platforms;
  final List<GamePreview> similarGames;

  const GameDetail({
    required super.id,
    required super.name,
    super.coverImageId,
    this.rating,
    this.summary,
    this.developer,
    this.releaseDateHuman,
    this.genres = const [],
    this.screenshots = const [],
    this.platforms = const [],
    this.similarGames = const [],
  });

  factory GameDetail.fromJson(Map<String, dynamic> json) {
    final companies = json['involved_companies'] as List<dynamic>? ?? [];
    String? developer;
    if (companies.isNotEmpty) {
      final company =
          (companies.first as Map<String, dynamic>)['company'] as Map<String, dynamic>?;
      developer = company?['name'] as String?;
    }

    final releaseDates = json['release_dates'] as List<dynamic>? ?? [];
    String? releaseDateHuman;
    if (releaseDates.isNotEmpty) {
      releaseDateHuman =
          (releaseDates.first as Map<String, dynamic>)['human'] as String?;
    }

    return GameDetail(
      id: json['id'].toString(),
      name: json['name'] as String? ?? 'Unknown',
      coverImageId: (json['cover'] as Map<String, dynamic>?)?['image_id'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      summary: json['summary'] as String?,
      developer: developer,
      releaseDateHuman: releaseDateHuman,
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((g) => Genre.fromJson(g as Map<String, dynamic>))
          .toList(),
      screenshots: (json['screenshots'] as List<dynamic>? ?? [])
          .map((s) => Screenshot.fromJson(s as Map<String, dynamic>))
          .toList(),
      platforms: (json['platforms'] as List<dynamic>? ?? [])
          .map((p) => Platform.fromJson(p as Map<String, dynamic>))
          .toList(),
      similarGames: (json['similar_games'] as List<dynamic>? ?? [])
          .map((g) => GamePreview.fromJson(g as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Genre {
  final String id;
  final String name;

  const Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'].toString(),
        name: json['name'] as String? ?? '',
      );
}

class Screenshot {
  final String id;
  final String imageId;

  const Screenshot({required this.id, required this.imageId});

  factory Screenshot.fromJson(Map<String, dynamic> json) => Screenshot(
        id: json['id'].toString(),
        imageId: json['image_id'] as String? ?? '',
      );
}

class Platform {
  final String id;
  final String name;

  const Platform({required this.id, required this.name});

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        id: json['id'].toString(),
        name: json['name'] as String? ?? '',
      );
}

class GameCategoryConfig {
  final String id;
  final String title;
  final String query;

  const GameCategoryConfig({
    required this.id,
    required this.title,
    required this.query,
  });
}
