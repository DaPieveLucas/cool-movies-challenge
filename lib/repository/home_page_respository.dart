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
}
