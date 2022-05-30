import 'package:coolmovies/model/movies_model.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class HomeFilmDescriptionWidget extends StatelessWidget {
  const HomeFilmDescriptionWidget({
    required this.moviesModel,
    Key? key,
  }) : super(key: key);

  final MoviesModel moviesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          moviesModel.title,
          style: DescriptionFont.movieCaption,
          textAlign: TextAlign.center,
        ),
        const Divider(
          color: AppColors.black,
        ),
        Text(
          'Release date: ${moviesModel.releaseDate}',
          style: DescriptionFont.movieSumarry,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
