import 'dart:convert';

class MoviesReviewModel {
  factory MoviesReviewModel.fromJson(String source) =>
      MoviesReviewModel.fromMap(json.decode(source));

  factory MoviesReviewModel.fromMap(Map<String, dynamic> map) {
    return MoviesReviewModel(
      body: map['body'] ?? '',
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      rating: map['rating']?.toInt() ?? 0,
    );
  }
  MoviesReviewModel({
    required this.body,
    required this.title,
    required this.rating,
    this.id,
  });
  final String body;
  final String? id;
  final String title;
  final int rating;

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'id': id,
      'title': title,
      'rating': rating,
    };
  }

  String toJson() => json.encode(toMap());
}
