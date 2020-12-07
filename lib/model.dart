import 'package:equatable/equatable.dart';

class Scientist extends Equatable {
  final int id;
  final String knownFor;
  final String name;
  final String imageUrl;

  Scientist({
    this.id,
    this.knownFor,
    this.name,
    this.imageUrl,
  });

  static Scientist fromJson(Map<String, dynamic> json) {
    return Scientist(
        id: json['id'],
        name: json['name'],
        knownFor: json['known_for'],
        imageUrl: json['image_url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'known_for': knownFor,
      'image_url': imageUrl
    };
  }

  @override
  List<Object> get props => [id, name, knownFor, imageUrl];
}
