import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';

// Importamos nuestros blocs y páginas
import 'features/daily_news/presentation/bloc/article/article_bloc.dart';
import 'features/daily_news/presentation/pages/home/daily_news.dart';
import 'features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'features/daily_news/domain/entities/article.dart';

import 'features/daily_news/domain/usecases/get_article.dart';
import 'features/daily_news/domain/repository/article_repository.dart';

// Simulación temporal de datos
class FakeArticleRepository implements ArticleRepository {
  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return DataSuccess([
      ArticleEntity(
        title: 'Breaking News!',
        description: 'Una noticia de prueba con datos simulados.',
        urlToImage: 'https://picsum.photos/200/300',
        content: 'Contenido extendido del artículo de ejemplo.',
      ),
      ArticleEntity(
        title: 'Otra noticia interesante',
        description: 'Más contenido para mostrar en la lista.',
        urlToImage: 'https://picsum.photos/200/301',
        content: 'Más texto simulado del segundo artículo.',
      ),
    ]);
  }

  // Implementaciones vacías para otros métodos
  @override
  Future<void> removeArticle(ArticleEntity article) async {}

  @override
  Future<void> saveArticle(ArticleEntity article) async {}

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      ArticleEntity(
        title: 'Artículo guardado',
        description: 'Ejemplo de artículo guardado localmente.',
        urlToImage: 'https://picsum.photos/200/305',
        content: 'Contenido simulado para pruebas locales.',
      ),
    ];
  }
}

void main() {
  final repository = FakeArticleRepository();
  final getArticleUseCase = GetArticleUseCase(repository);

  runApp(MyApp(getArticleUseCase: getArticleUseCase));
}

class MyApp extends StatelessWidget {
  final GetArticleUseCase getArticleUseCase;

  const MyApp({Key? key, required this.getArticleUseCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ArticleBloc(getArticleUseCase),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily News',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        initialRoute: '/',
        routes: {
          '/': (context) => const DailyNewsPage(),
          '/article_detail': (context) {
            final article =
                ModalRoute.of(context)!.settings.arguments as ArticleEntity;
            return ArticleDetailsView(article: article);
          },
        },
      ),
    );
  }
}
