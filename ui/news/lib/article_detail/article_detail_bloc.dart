import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news.dart';
import 'package:news_ui/article_detail/article_detail_state.dart';

class ArticleDetailCubit extends Cubit<ArticleDetailState> {
  final GetArticleDetail _getArticleDetail;
  final int _articleId;

  ArticleDetailCubit(this._getArticleDetail, this._articleId)
      : super(const ArticleDetailLoading()) {
    _fetchArticleDetail();
  }

  void reload() {
    emit(const ArticleDetailLoading());
    _fetchArticleDetail();
  }

  Future<void> _fetchArticleDetail() async {
    final result = await _getArticleDetail(_articleId);

    switch (result) {
      case Success(:final data):
        emit(ArticleDetailSuccess(data));
      case Failure(:final error):
        emit(ArticleDetailError(error.message));
    }
  }
}
