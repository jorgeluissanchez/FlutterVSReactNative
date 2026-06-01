import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get clientId {
    final value = dotenv.env['IGDB_CLIENT_ID'];
    if (value == null || value.isEmpty) {
      throw StateError(
        'Falta IGDB_CLIENT_ID. Copia .env.example a .env y configura las credenciales.',
      );
    }
    return value;
  }

  static String get authToken {
    final value = dotenv.env['IGDB_AUTH_TOKEN'];
    if (value == null || value.isEmpty) {
      throw StateError(
        'Falta IGDB_AUTH_TOKEN. Copia .env.example a .env y configura las credenciales.',
      );
    }
    return value;
  }

  static Map<String, String> get igdbHeaders => {
        'client-id': clientId,
        'Authorization': authToken,
        'Content-Type': 'text/plain',
        'Accept': 'application/json',
      };
}
