import 'package:flutter/material.dart';

import '../pages/film_specifications_view.dart';
import '../utils/app_images.dart';
import 'film_description_widget.dart';

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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FilmSpecificationsView(),
            ),
          );
        },
        child: const Card(
          elevation: 20,
          child: Padding(
            padding: EdgeInsets.all(
              5,
            ),
            child: _CardContent(),
          ),
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({Key? key}) : super(key: key);

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
            builder: (context, constraints) => FilmDescriptionWidget(),
          ),
        ),
      ],
    );
  }
}
