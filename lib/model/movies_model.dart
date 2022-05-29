import 'dart:convert';

import 'movies_reviw_model.dart';

class MoviesModel {
  factory MoviesModel.fromJson(String source) =>
      MoviesModel.fromMap(json.decode(source));

  factory MoviesModel.fromMap(Map<String, dynamic> map) {
    return MoviesModel(
      id: map['id'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      movieDirectorId: map['movieDirectorId'] ?? '',
      userCreatorId: map['userCreatorId'] ?? '',
      title: map['title'] ?? '',
      releaseDate: map['releaseDate'] ?? '',
      nodeId: map['nodeId'] ?? '',
      moviesReviewModel: List<MoviesReviewModel>.from(
        map['movieReviewsByMovieId']['nodes']
            ?.map((x) => MoviesReviewModel.fromMap(x)),
      ),
    );
  }

  MoviesModel({
    required this.id,
    required this.imgUrl,
    required this.movieDirectorId,
    required this.userCreatorId,
    required this.title,
    required this.releaseDate,
    required this.nodeId,
    required this.moviesReviewModel,
  });

  final String id;
  final String imgUrl;
  final String movieDirectorId;
  final String userCreatorId;
  final String title;
  final String releaseDate;
  final String nodeId;
  final List<MoviesReviewModel> moviesReviewModel;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imgUrl': imgUrl,
      'movieDirectorId': movieDirectorId,
      'userCreatorId': userCreatorId,
      'title': title,
      'releaseDate': releaseDate,
      'nodeId': nodeId,
      'movieReviewsByMovieId': moviesReviewModel.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
