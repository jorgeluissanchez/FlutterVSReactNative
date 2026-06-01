import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/comments_provider.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: '.env');
  } catch (error) {
    runApp(
      EnvErrorApp(
        message:
            'No se pudo cargar el archivo .env como asset.\n$error\n\n'
            'Asegúrate de que exista FlutterComparationDemo/.env, '
            'ejecuta "flutter pub get" y reinicia la app por completo (no hot reload).',
      ),
    );
    return;
  }

  if (dotenv.env['IGDB_CLIENT_ID'] == null ||
      dotenv.env['IGDB_CLIENT_ID']!.isEmpty ||
      dotenv.env['IGDB_AUTH_TOKEN'] == null ||
      dotenv.env['IGDB_AUTH_TOKEN']!.isEmpty) {
    runApp(
      const EnvErrorApp(
        message:
            'El archivo .env existe pero faltan IGDB_CLIENT_ID o IGDB_AUTH_TOKEN.\n'
            'Copia .env.example a .env y pega tus credenciales IGDB.',
      ),
    );
    return;
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => CommentsProvider(),
      child: const ComparationApp(),
    ),
  );
}

class EnvErrorApp extends StatelessWidget {
  final String message;

  const EnvErrorApp({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Error al cargar .env',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(message),
                const SizedBox(height: AppSpacing.lg),
                const Text(
                  'Copia .env.example a .env en la raíz del proyecto y configura IGDB_CLIENT_ID e IGDB_AUTH_TOKEN.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
