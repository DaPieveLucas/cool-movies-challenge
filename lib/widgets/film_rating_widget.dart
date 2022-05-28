import 'package:coolmovies/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FilmRatingWidget extends StatelessWidget {
  const FilmRatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 20,
      initialRating: 3,
      minRating: 1,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: AppColors.gold,
        size: 10,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
