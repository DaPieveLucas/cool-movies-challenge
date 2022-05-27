import 'package:auto_size_text/auto_size_text.dart';
import 'package:coolmovies/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../theme/app_text_style.dart';
import '../utils/app_images.dart';

class FilmCardWidget extends StatelessWidget {
  const FilmCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: 220,
      width: double.maxFinite,
      child: Card(
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(
            5,
          ),
          child: _CardContent(),
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  _CardContent({AutoSizeGroup? autoSizeGroup, Key? key})
      : _autoSizeGroup = autoSizeGroup ?? AutoSizeGroup(),
        super(key: key);

  final AutoSizeGroup _autoSizeGroup;

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
                child: Image.asset(
                  AppImages.avengersPost,
                ),
              );
            }),
          ),
        ),
        Expanded(
          flex: 3,
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
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
            ),
          ),
        ),
      ],
    );
  }
}
