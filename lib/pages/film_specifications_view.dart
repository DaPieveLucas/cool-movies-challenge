import 'package:coolmovies/theme/app_colors.dart';
import 'package:coolmovies/utils/app_images.dart';
import 'package:flutter/material.dart';

import '../theme/app_text_style.dart';
import '../widgets/film_description_widget.dart';
import '../widgets/film_rating_widget.dart';

class FilmSpecificationsView extends StatelessWidget {
  const FilmSpecificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Summary',
          style: HeadingFont.headingLargeWhite,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.appBarBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.black,
                  blurRadius: 50.0,
                )
              ],
            ),
            height: 400,
            width: 300,
            child: Card(
              color: GrayScale.gray100,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(AppImages.avengersPost),
                        ),
                      ),
                      const FilmRatingWidget(),
                      FilmDescriptionWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
