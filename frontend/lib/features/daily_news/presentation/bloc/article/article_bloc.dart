import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/article.dart';
import '../../../domain/usecases/get_article.dart';
part 'article_state.dart';

/// Bloc encargado de manejar los artículos de noticias
class ArticleBloc extends Cubit<ArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  ArticleBloc(this._getArticleUseCase) : super(ArticleInitial());

  Future<void> loadArticles() async {
    emit(ArticleLoading());
    try {
      final result = await _getArticleUseCase.call();

      if (result.data != null) {
        emit(ArticleLoaded(result.data!));
      } else {
        emit(ArticleError('No se encontraron artículos.'));
      }
    } catch (e) {
      emit(ArticleError('Error al cargar los artículos: $e'));
    }
  }
}
