import 'package:coolmovies/controller/home_page_controller.dart';
import 'package:coolmovies/model/movies_model.dart';
import 'package:coolmovies/model/movies_reviw_model.dart';
import 'package:flutter/material.dart';

import '../widgets/empty_state.dart';

import '../widgets/film_card_widget.dart';
import '../widgets/sliver_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController controller = HomePageController();

  @override
  void initState() {
    super.initState();

    controller.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ValueListenableBuilder<List<MoviesModel>?>(
        valueListenable: controller.data,
        builder: (context, movies, _) {
          if (movies == null) {
            return const EmptyState();
          }
          return SliverWidget(
            sliverList: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  final MoviesModel movie = movies[index];
                  final MoviesReviewModel movieReview =
                      movies[index].moviesReviewModel[index];

                  return FilmCardWidget(
                    movieModel: movie,
                    moviesReviewModel: movieReview,
                    moviesList: movies,
                  );
                }),
                childCount: movies.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
        //TODO tratar os outros estados
        // if (result.hasException) {
        //   return ExceptionWidget(exception: result.exception.toString());
        // }
        // if (result.isLoading) {
        //   return const LoadingScreen();
        // }

        // final List? movies = result.data?['allMovies']['nodes'];

        // if (movies == null) {
        //   return const EmptyState();
        // }


