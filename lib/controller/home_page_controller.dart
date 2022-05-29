import 'package:coolmovies/model/movies_model.dart';
import 'package:coolmovies/repository/home_page_respository.dart';
import 'package:flutter/material.dart';

class HomePageController {
  final ValueNotifier<List<MoviesModel>?> data = ValueNotifier(null);
  final HomePageRepository _repository = HomePageRepository();

  Future<void> fetchMovies() async {
    print('Fetching movies');
    final movies = await _repository.getMovies();
    data.value = movies;
  }
}
