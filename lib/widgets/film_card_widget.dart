import 'package:coolmovies/model/movies_model.dart';
import 'package:coolmovies/model/movies_reviw_model.dart';
import 'package:flutter/material.dart';

import '../pages/film_specifications_view.dart';
import 'home_film_description_widget.dart';

class FilmCardWidget extends StatelessWidget {
  const FilmCardWidget({
    required this.moviesReviewModel,
    required this.movieModel,
    required this.moviesList,
    Key? key,
  }) : super(key: key);

  final MoviesModel movieModel;
  final MoviesReviewModel moviesReviewModel;
  final List<MoviesModel> moviesList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: 220,
      width: double.maxFinite,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilmSpecificationsView(
                movieModel: movieModel,
              ),
            ),
          );
        },
        child: Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(
              5,
            ),
            child: _CardContent(
              moviesModel: movieModel,
              moviesReviewModel: moviesReviewModel,
            ),
          ),
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.moviesModel,
    required this.moviesReviewModel,
    Key? key,
  }) : super(key: key);

  final MoviesModel moviesModel;
  final MoviesReviewModel moviesReviewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: LayoutBuilder(
            builder: ((context, constraints) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(moviesModel.imgUrl),
              );
            }),
          ),
        ),
        Expanded(
          flex: 3,
          child: HomeFilmDescriptionWidget(
            moviesModel: moviesModel,
          ),
        ),
      ],
    );
  }
}
