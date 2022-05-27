import 'package:flutter/material.dart';

import '../theme/app_text_style.dart';
import '../utils/app_images.dart';

class SliverWidget extends StatelessWidget {
  const SliverWidget({required this.sliverList, Key? key}) : super(key: key);

  final SliverList sliverList;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Cool Movies',
              textAlign: TextAlign.center,
              style: HeadingFont.headingLargeWhite,
            ),
            background: ClipRRect(
              borderRadius: BorderRadius.circular(17.0),
              child: Image.asset(
                AppImages.appBarBackground,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
        sliverList,
      ],
    );
  }
}
