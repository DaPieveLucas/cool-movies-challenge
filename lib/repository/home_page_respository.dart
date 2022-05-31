import 'package:coolmovies/model/movies_reviw_model.dart';
import 'package:coolmovies/utils/navigation_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/movies_model.dart';

class HomePageRepository {
  Future<List<MoviesModel>> getMovies() async {
    final client = GraphQLProvider.of(
      NavigationService.navigatorKey.currentState!.overlay!.context,
    ).value;

    print('Getting movies');
    final QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          r'''
          query AllMovies {
            allMovies {
              nodes {
                id
                imgUrl
                movieDirectorId
                userCreatorId
                title
                releaseDate
                nodeId
                movieReviewsByMovieId {
                  nodes {
                    body
                    id
                    rating
                    title
                  }
                }
                userByUserCreatorId {
                  id
                  name
                  nodeId
                }
              }
            }
          }
        ''',
        ),
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
    }

    if (result.data != null) {
      final List movies = result.data?['allMovies']['nodes'];
      return movies.map((e) => MoviesModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<void> createReview(
    MoviesReviewModel moviesReview,
    MoviesModel moviesModel,
  ) async {
    final client = GraphQLProvider.of(
      NavigationService.navigatorKey.currentState!.overlay!.context,
    ).value;

    print('Creating review');
    final QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(
          '''
          mutation {
            createMovieReview(input: {
              movieReview: {
                title: "${moviesReview.title}",
                body: "${moviesReview.body}",
                rating: ${moviesReview.rating},
                movieId: "${moviesModel.id}",
                userReviewerId: "${moviesModel.userCreatorId}"
              }})
            {
              movieReview {
                id
                title
                body
                rating
                movieByMovieId {
                  title
                }
                userByUserReviewerId {
                  name
                }
              }
            }
          }
        ''',
        ),
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
    }

    if (result.data != null) {
      print('review criada com sucesso');
    }
  }

  Future<void> editReview(
    MoviesReviewModel moviesReview,
    MoviesModel moviesModel,
  ) async {
    final client = GraphQLProvider.of(
      NavigationService.navigatorKey.currentState!.overlay!.context,
    ).value;

    print('Editing review');
    final QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(
          '''
          mutation {
            createMovieReview(input: {
              movieReview: {
                id: "${moviesReview.id}"
                title: "${moviesReview.title}",
                body: "${moviesReview.body}",
                rating: ${moviesReview.rating},
                movieId: "${moviesModel.id}",
                userReviewerId: "${moviesModel.userCreatorId}"
              }})
            {
              movieReview {
                id
                title
                body
                rating
                movieByMovieId {
                  title
                }
                userByUserReviewerId {
                  name
                }
              }
            }
          }
        ''',
        ),
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
    }

    if (result.data != null) {
      print('review editada com sucesso');
    }
  }
}
