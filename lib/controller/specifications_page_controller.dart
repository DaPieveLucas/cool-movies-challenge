import '../model/movies_model.dart';
import '../model/movies_reviw_model.dart';
import '../repository/home_page_respository.dart';

class SpecificationsPageController {
  final HomePageRepository _repository = HomePageRepository();

  Future<void> createReview(
    MoviesReviewModel moviesReview,
    MoviesModel moviesModel,
  ) async {
    await _repository.createReview(
      moviesReview,
      moviesModel,
    );
  }
}
