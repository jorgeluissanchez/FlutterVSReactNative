import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/fetch_result.dart';
import '../models/game.dart';
import '../services/igdb_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_loader.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/game_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _searchTerm = '';
  Future<FetchResult<List<SearchResult>>>? _future;

  void _handleSearch() {
    final trimmed = _controller.text.trim();
    if (trimmed.isEmpty) return;
    setState(() {
      _searchTerm = trimmed;
      _future = IgdbService.instance.searchGames(trimmed);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const BackButtonWidget(),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.xs,
                  AppSpacing.xs,
                  AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.black),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Search games...',
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => _handleSearch(),
                      ),
                    ),
                    Material(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: _handleSearch,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.md,
                          ),
                          child: Text(
                            'Buscar',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: _future == null
                    ? const SizedBox.shrink()
                    : FutureBuilder<FetchResult<List<SearchResult>>>(
                        future: _future,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const AppLoader();
                          }
                          if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(color: AppColors.delete),
                            );
                          }

                          final result = snapshot.data!;
                          final results = result.data;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'API: ${result.durationMs} ms',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              if (results.isEmpty)
                                const Text(
                                  'No se encontraron juegos.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              else
                                Expanded(
                                  child: GridView.builder(
                                    key: ValueKey('search-$_searchTerm'),
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: AppSpacing.md,
                                      mainAxisSpacing: AppSpacing.md,
                                      childAspectRatio: 0.62,
                                    ),
                                    itemCount: results.length,
                                    itemBuilder: (context, index) {
                                      final item = results[index];
                                      return Center(
                                        child: GameCard(
                                          game: item.game.id.isNotEmpty
                                              ? item.game
                                              : GamePreview(
                                                  id: item.id,
                                                  name: item.game.name,
                                                  coverImageId:
                                                      item.game.coverImageId,
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
