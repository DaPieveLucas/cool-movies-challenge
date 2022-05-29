import 'package:auto_size_text/auto_size_text.dart';
import 'package:coolmovies/model/movies_model.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class FilmDescriptionWidget extends StatelessWidget {
  FilmDescriptionWidget({
    required this.moviesModel,
    AutoSizeGroup? autoSizeGroup,
    Key? key,
  })  : _autoSizeGroup = autoSizeGroup ?? AutoSizeGroup(),
        super(key: key);

  final AutoSizeGroup _autoSizeGroup;
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
        AutoSizeText(
          //TODO tratar a data que vem da API
          moviesModel.releaseDate,
          style: DescriptionFont.movieSumarry,
          maxLines: 9,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          group: _autoSizeGroup,
        ),
      ],
    );
  }
}
