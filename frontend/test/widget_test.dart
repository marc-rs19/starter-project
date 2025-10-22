import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news_app_clean_architecture/main.dart';

// imports de dominio
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';

// Fake mínimo para el test
class _FakeArticleRepository implements ArticleRepository {
  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async =>
      DataSuccess(<ArticleEntity>[]);

  @override
  Future<List<ArticleEntity>> getSavedArticles() async => <ArticleEntity>[];

  @override
  Future<void> removeArticle(ArticleEntity article) async {}

  @override
  Future<void> saveArticle(ArticleEntity article) async {}
}

void main() {
  testWidgets('renderiza la home Daily News', (WidgetTester tester) async {
    final useCase = GetArticleUseCase(_FakeArticleRepository());

    // NOTA: ya no es const porque le pasamos un argumento.
    await tester.pumpWidget(MyApp(getArticleUseCase: useCase));

    // Aseguramos que aparece el título de la app
    expect(find.text('Daily News'), findsOneWidget);
  });
}
