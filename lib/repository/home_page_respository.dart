import 'package:coolmovies/utils/navigation_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/movies_model.dart';
import '../widgets/exception_widget.dart';

class HomePageRepository {
  final _client = GraphQLProvider.of(
    NavigationService.navigatorKey.currentState!.overlay!.context,
  ).value;

  Future<List<MoviesModel>> getMovies() async {
    print('Getting movies');

    const String moviesCallBack = r'''
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
        ''';

    final QueryResult result = await _client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(
          moviesCallBack,
        ),
      ),
    );

    if (result.hasException) {
      ExceptionWidget(
        exception: result.exception.toString(),
      );
    }

    if (result.data != null) {
      final List movies = result.data?['allMovies']['nodes'];

      return movies.map((e) => MoviesModel.fromMap(e)).toList();
    }
    return [];
  }
}
