import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/article/article_bloc.dart';
import '../../../domain/entities/article.dart';

class DailyNewsPage extends StatelessWidget {
  const DailyNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily News'),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArticleLoaded) {
            final List<ArticleEntity> articles = state.articles;

            if (articles.isEmpty) {
              return const Center(child: Text('No hay artículos disponibles.'));
            }

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(article.title ?? 'Sin título'),
                    subtitle: Text(article.description ?? 'Sin descripción'),
                    leading: article.urlToImage != null
                        ? Image.network(article.urlToImage!, width: 80)
                        : const Icon(Icons.article_outlined),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/article_detail',
                        arguments: article,
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is ArticleError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(
                child: Text('Pulsa el botón para cargar artículos.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          context.read<ArticleBloc>().loadArticles();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
