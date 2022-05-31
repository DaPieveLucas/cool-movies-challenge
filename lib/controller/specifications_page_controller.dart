import 'package:coolmovies/controller/home_page_controller.dart';
import 'package:flutter/cupertino.dart';

import '../model/movies_model.dart';
import '../model/movies_reviw_model.dart';
import '../repository/home_page_respository.dart';

class SpecificationsPageController {
  final HomePageRepository _repository = HomePageRepository();
  final HomePageController homeController = HomePageController();
  final ValueNotifier<List<MoviesReviewModel?>?> notifier =
      ValueNotifier<List<MoviesReviewModel?>?>(null);

  Future<void> createReview(
    MoviesReviewModel moviesReview,
    MoviesModel moviesModel,
  ) async {
    await _repository.createReview(
      moviesReview,
      moviesModel,
    );

    addValueNotifier(moviesReview);

    await homeController.fetchMovies();
  }

  Future<void> editingReview(
    MoviesReviewModel moviesReview,
    MoviesModel moviesModel,
    int listIndex,
  ) async {
    await _repository.editReview(
      moviesReview,
      moviesModel,
    );

    updateValueNotifier(moviesReview, listIndex);

    await homeController.fetchMovies();
  }

  void updateValueNotifier(MoviesReviewModel updatedReview, int index) {
    final newList = [...?notifier.value];

    newList[index] = updatedReview;

    notifier.value = newList;
  }

  Future<void> initializeReviews(
    List<MoviesReviewModel> moviesReview,
  ) async {
    notifier.value = moviesReview;
  }

  void addValueNotifier(MoviesReviewModel newReview) {
    notifier.value = [...?notifier.value, newReview];
  }
}
