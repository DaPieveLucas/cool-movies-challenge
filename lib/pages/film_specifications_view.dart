import 'package:auto_size_text/auto_size_text.dart';
import 'package:coolmovies/controller/home_page_controller.dart';
import 'package:coolmovies/controller/specifications_page_controller.dart';
import 'package:coolmovies/model/movies_model.dart';
import 'package:coolmovies/model/movies_reviw_model.dart';
import 'package:coolmovies/theme/app_colors.dart';
import 'package:coolmovies/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../theme/app_text_style.dart';

class FilmSpecificationsView extends StatefulWidget {
  const FilmSpecificationsView({required this.movieModelReview, Key? key})
      : super(key: key);

  final MoviesModel movieModelReview;

  @override
  State<FilmSpecificationsView> createState() => _FilmSpecificationsViewState();
}

class _FilmSpecificationsViewState extends State<FilmSpecificationsView> {
  final SpecificationsPageController controller =
      SpecificationsPageController();

  final HomePageController refreshcontroller = HomePageController();
  late TextEditingController textBodyController;
  late TextEditingController textTitleController;
  String title = '';
  String body = '';
  double submitRating = 0.0;

  @override
  void initState() {
    super.initState();

    textBodyController = TextEditingController();
    textTitleController = TextEditingController();
  }

  @override
  void dispose() {
    textBodyController.dispose();
    textTitleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.of(context).pop();

      controller.createReview(
        MoviesReviewModel(
          body: body,
          title: title,
          rating: submitRating.toInt(),
        ),
        widget.movieModelReview,
      );
      print(title);
      print(body);
      print('this -> $submitRating');

      textBodyController.clear();
      textTitleController.clear();
    }

    Future<void> openDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Moview review',
              style: DescriptionFont.movieCaption,
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                    autofocus: true,
                    controller: textTitleController,
                    decoration: const InputDecoration(
                      hintText: 'title of review',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: textBodyController,
                    onChanged: (value) {
                      setState(() {
                        body = value;
                      });
                    },
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'body of review',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RatingBar.builder(
                    itemSize: 15,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppColors.gold,
                      size: 10,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        submitRating = rating;
                      });
                    },
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: submit,
                child: const Text('Submit'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      // depois que criar nova review, fazer novo get para pegar reviews
      // criar edição para reviews
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
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(widget.movieModelReview.imgUrl),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => setState(() {
                  refreshcontroller.fetchMovies();
                }),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    final List<MoviesReviewModel> moviesReviewList =
                        widget.movieModelReview.moviesReviewModel;

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: GrayScale.gray100,
                        child: ListTile(
                          title: Column(
                            children: [
                              Text(
                                'Review: ${moviesReviewList[index].title}',
                                style: DescriptionFont.movieCaption,
                              ),
                              const Divider(
                                color: AppColors.black,
                              ),
                              AutoSizeText(
                                moviesReviewList[index].body,
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
                            child: RatingBarIndicator(
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              rating: moviesReviewList[index].rating.toDouble(),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: AppColors.gold,
                                size: 10,
                              ),
                              itemSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  itemCount: widget.movieModelReview.moviesReviewModel.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
