import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class FilmDescriptionWidget extends StatelessWidget {
  FilmDescriptionWidget({AutoSizeGroup? autoSizeGroup, Key? key})
      : _autoSizeGroup = autoSizeGroup ?? AutoSizeGroup(),
        super(key: key);

  final AutoSizeGroup _autoSizeGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Avengers Age of Ultron',
          style: DescriptionFont.movieCaption,
          textAlign: TextAlign.center,
        ),
        const Divider(
          color: AppColors.black,
        ),
        AutoSizeText(
          'Earth mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.',
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
