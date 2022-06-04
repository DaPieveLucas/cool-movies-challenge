import 'package:coolmovies/controller/home_page_controller.dart';
import 'package:flutter/material.dart';

import '../model/movies_model.dart';
import '../model/movies_reviw_model.dart';
import '../repository/movie_review_repository.dart';
import '../utils/navigation_service.dart';
import '../utils/review_dialog.dart';

class SpecificationsPageController {
  final MovieReviewRepository _repository = MovieReviewRepository();
  final HomePageController homeController = HomePageController();
  final ValueNotifier<List<MoviesReviewModel?>?> notifier =
      ValueNotifier<List<MoviesReviewModel?>?>(null);
  BuildContext showContext =
      NavigationService.navigatorKey.currentState!.overlay!.context;

  TextEditingController textTitleController = TextEditingController();
  TextEditingController textBodyController = TextEditingController();

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
    print('edit realizado com sucesso');
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

  void submit(
    double newRating,
    MoviesModel movieModel,
  ) {
    Navigator.of(showContext).pop();

    createReview(
      MoviesReviewModel(
        body: textBodyController.text,
        title: textTitleController.text,
        rating: newRating.toInt(),
      ),
      movieModel,
    );

    textBodyController.clear();
    textTitleController.clear();
  }

  void editReviewCallback(
    int index,
    double newRating,
    String id,
    MoviesModel movieModel,
  ) {
    Navigator.of(showContext).pop();

    print(textBodyController.text);
    print(textTitleController.text);
    print('filme editado com sucesso');

    editingReview(
      MoviesReviewModel(
        body: textBodyController.text,
        title: textTitleController.text,
        rating: newRating.toInt(),
        id: id,
      ),
      movieModel,
      index,
    );

    textBodyController.clear();
    textTitleController.clear();
  }

  Future<void> openDialog(
    bool isEditing,
    MoviesModel moviesModel, {
    int? index,
    String? id,
  }) {
    return showDialog(
      context: showContext,
      builder: (context) {
        return ReviewDialogWidget(
          controller: this,
          isEdited: isEditing,
          submitButton: (rating) => submit(rating, moviesModel),
          editButton: (rating) =>
              editReviewCallback(index ?? 0, rating, id!, moviesModel),
        );
      },
    );
  }
}
