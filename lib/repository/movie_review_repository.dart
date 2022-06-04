import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/movies_model.dart';
import '../model/movies_reviw_model.dart';
import '../utils/navigation_service.dart';
import '../widgets/exception_widget.dart';

class MovieReviewRepository {
  final _client = GraphQLProvider.of(
    NavigationService.navigatorKey.currentState!.overlay!.context,
  ).value;

  Future<void> createReview(
    MoviesReviewModel moviesReview,
    MoviesModel moviesModel,
  ) async {
    print('Creating review');

    final String createReview = '''
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
        ''';

    final QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(createReview),
      ),
    );

    if (result.hasException) {
      ExceptionWidget(
        exception: result.exception.toString(),
      );
    }

    if (result.data != null) {
      print('review criada com sucesso');
    }
  }

  Future<void> editReview(
    MoviesReviewModel moviesReview,
    MoviesModel moviesModel,
  ) async {
    print('Editing review');

    final String update = '''
            mutation MoviewReviewById {
          updateMovieReviewById(
            input: {movieReviewPatch: {body: "${moviesReview.body}", rating: ${moviesReview.rating}, title: "${moviesReview.title}"}, id: "${moviesReview.id}"}
          ) {
            clientMutationId
            movieReview {
              body
              title
              rating
            }
          }
        }
    ''';

    final QueryResult result = await _client.mutate(
      MutationOptions(document: gql(update)),
    );

    if (result.hasException) {
      ExceptionWidget(
        exception: result.exception.toString(),
      );
    }

    if (result.data != null) {
      print('review editada com sucesso');
    }
  }
}
