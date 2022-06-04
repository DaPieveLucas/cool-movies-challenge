import 'package:auto_size_text/auto_size_text.dart';
import 'package:coolmovies/controller/home_page_controller.dart';
import 'package:coolmovies/controller/specifications_page_controller.dart';
import 'package:coolmovies/model/movies_model.dart';
import 'package:coolmovies/model/movies_reviw_model.dart';
import 'package:coolmovies/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../theme/app_text_style.dart';

class FilmSpecificationsView extends StatefulWidget {
  const FilmSpecificationsView({required this.movieModel, Key? key})
      : super(key: key);

  final MoviesModel movieModel;

  @override
  State<FilmSpecificationsView> createState() => _FilmSpecificationsViewState();
}

class _FilmSpecificationsViewState extends State<FilmSpecificationsView> {
  final SpecificationsPageController controller =
      SpecificationsPageController();

  final HomePageController refreshcontroller = HomePageController();

  @override
  void initState() {
    super.initState();

    controller.initializeReviews(widget.movieModel.moviesReviewModel);

    controller.textBodyController;
    controller.textTitleController;
  }

  @override
  void dispose() {
    controller.textBodyController.dispose();
    controller.textTitleController.dispose();

    super.dispose();
  }

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
      body: Column(
        children: [
          SizedBox(
            height: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(widget.movieModel.imgUrl),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await refreshcontroller.fetchMovies();
              },
              child: ValueListenableBuilder<List<MoviesReviewModel?>?>(
                valueListenable: controller.notifier,
                builder: (context, moviesReview, _) {
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      final List<MoviesReviewModel?>? moviesReviewList =
                          moviesReview;

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          color: GrayScale.gray100,
                          child: ListTile(
                            title: Column(
                              children: [
                                Text(
                                  'Review: ${moviesReviewList![index]?.title}',
                                  style: DescriptionFont.movieCaption,
                                ),
                                const Divider(
                                  color: AppColors.black,
                                ),
                                AutoSizeText(
                                  moviesReviewList[index]?.body ?? '',
                                  style: DescriptionFont.movieSumarry,
                                  maxLines: 9,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            subtitle: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => controller.openDialog(
                                      true,
                                      widget.movieModel,
                                      index: index,
                                      id: widget.movieModel
                                          .moviesReviewModel[index].id,
                                    ),
                                    child: const Text('Edit'),
                                  ),
                                  RatingBarIndicator(
                                    itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    rating: moviesReviewList[index]!
                                        .rating
                                        .toDouble(),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: AppColors.gold,
                                      size: 10,
                                    ),
                                    itemSize: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    itemCount: moviesReview!.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.openDialog(false, widget.movieModel);
        },
        child: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
