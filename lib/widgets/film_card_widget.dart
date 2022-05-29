import 'package:coolmovies/model/movies_model.dart';
import 'package:flutter/material.dart';

import '../pages/film_specifications_view.dart';
import 'film_description_widget.dart';

class FilmCardWidget extends StatelessWidget {
  const FilmCardWidget({required this.moviesModel, Key? key}) : super(key: key);

  final MoviesModel moviesModel;

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
              builder: (context) =>
                  FilmSpecificationsView(moviesModel: moviesModel),
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
              movieImage: moviesModel.imgUrl,
              moviesModel: moviesModel,
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
    required this.movieImage,
    Key? key,
  }) : super(key: key);

  final String movieImage;
  final MoviesModel moviesModel;

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
                child: Image.network(movieImage),
              );
            }),
          ),
        ),
        Expanded(
          flex: 3,
          child: LayoutBuilder(
            builder: (context, constraints) =>
                FilmDescriptionWidget(moviesModel: moviesModel),
          ),
        ),
      ],
    );
  }
}
