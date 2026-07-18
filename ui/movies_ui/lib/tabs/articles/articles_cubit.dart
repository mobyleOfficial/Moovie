import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news/news.dart';
import 'package:movies_ui/tabs/articles/articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final GetArticles _getArticles;

  int _totalPages = 1;

  late final PagingController<int, Article> pagingController = PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;

      if (nextKey > _totalPages) {
        return null;
      }
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  ArticlesCubit(this._getArticles) : super(const ArticlesLoading());

  Future<List<Article>> _fetchPage(int page) async {
    final result = await _getArticles(page);

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        return data.articles;
      case Failure(:final error):
        throw Exception(error.message);
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
