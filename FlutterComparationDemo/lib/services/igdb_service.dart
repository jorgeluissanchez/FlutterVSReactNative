import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/env_config.dart';
import '../models/event.dart';
import '../models/fetch_result.dart';
import '../models/game.dart';
import '../utils/image_utils.dart';

class IgdbService {
  IgdbService._();
  static final IgdbService instance = IgdbService._();

  final Map<String, dynamic> _cache = {};

  Future<FetchResult<List<GamePreview>>> fetchGamesByQuery(String query) async {
    return _fetchCached<List<GamePreview>>(
      'gameQuery:$query',
      () async {
        final list = await _postList('https://api.igdb.com/v4/games', query);
        return list.map((e) => GamePreview.fromJson(e)).toList();
      },
    );
  }

  Future<FetchResult<GameDetail>> fetchGame(String id) async {
    final query = '''
      fields name, cover.image_id, rating, genres.name, summary, platforms.name, release_dates.human,
      involved_companies.company.name,
      similar_games.id, similar_games.name, similar_games.cover.image_id,
      screenshots.image_id;
      where id = $id;
    ''';

    return _fetchCached<GameDetail>(
      'game:$id',
      () async {
        final list = await _postList('https://api.igdb.com/v4/games', query);
        if (list.isEmpty) throw Exception('Juego no encontrado');
        return GameDetail.fromJson(list.first);
      },
    );
  }

  Future<FetchResult<List<GameEventPreview>>> fetchGameEvents() async {
    const query = '''
      fields id, name, event_logo.image_id, start_time;
      sort start_time desc;
      limit 10;
    ''';

    return _fetchCached<List<GameEventPreview>>(
      'gameEvents',
      () async {
        final list = await _postList('https://api.igdb.com/v4/events', query);
        return list.map((e) => GameEventPreview.fromJson(e)).toList();
      },
    );
  }

  Future<FetchResult<GameEventDetail>> fetchGameEvent(String id) async {
    final query = '''
      fields id, name, description, event_logo.image_id, start_time, games.id, games.cover.image_id, games.name;
      where id=$id;
    ''';

    return _fetchCached<GameEventDetail>(
      'gameEvent:$id',
      () async {
        final list = await _postList('https://api.igdb.com/v4/events', query);
        if (list.isEmpty) throw Exception('Evento no encontrado');
        return GameEventDetail.fromJson(list.first);
      },
    );
  }

  Future<FetchResult<List<SearchResult>>> searchGames(String searchTerm) async {
    final query = '''
      fields game.id, game.cover.image_id, game.name;
      search "${escapeSearchTerm(searchTerm)}";
      limit 30;
    ''';

    return _fetchCached<List<SearchResult>>(
      'search:$searchTerm',
      () async {
        final list = await _postList('https://api.igdb.com/v4/search', query);
        return list
            .map((e) => SearchResult.fromJson(e))
            .where((r) => r.game.name.isNotEmpty)
            .toList();
      },
    );
  }

  Future<FetchResult<T>> _fetchCached<T>(
    String cacheKey,
    Future<T> Function() fetcher,
  ) async {
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey] as FetchResult<T>;
    }

    final stopwatch = Stopwatch()..start();
    final data = await fetcher();
    stopwatch.stop();

    final result = FetchResult<T>(
      data: data,
      durationMs: stopwatch.elapsedMilliseconds,
    );
    _cache[cacheKey] = result;
    return result;
  }

  Future<List<Map<String, dynamic>>> _postList(String url, String body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: EnvConfig.igdbHeaders,
      body: body,
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final body = response.body.length > 200
          ? '${response.body.substring(0, 200)}...'
          : response.body;
      throw Exception(
        'IGDB ${response.statusCode}: ${response.reasonPhrase}. $body',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) return [];
    return decoded.cast<Map<String, dynamic>>();
  }
}
