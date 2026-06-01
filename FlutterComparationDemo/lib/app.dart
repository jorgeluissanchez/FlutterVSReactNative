import 'package:flutter/material.dart';

import 'screens/comment_form_screen.dart';
import 'screens/game_details_screen.dart';
import 'screens/game_event_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'theme/app_theme.dart';

class ComparationApp extends StatelessWidget {
  const ComparationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterComparationDemo',
      theme: AppTheme.light,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/search':
            return MaterialPageRoute(builder: (_) => const SearchScreen());
          case '/game-details':
            final gameId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => GameDetailsScreen(gameId: gameId),
            );
          case '/game-event':
            final eventId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => GameEventScreen(eventId: eventId),
            );
          case '/comment-form':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => CommentFormScreen(
                gameId: args['gameId'] as String,
                commentId: args['commentId'] as String?,
              ),
            );
          default:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      },
    );
  }
}
