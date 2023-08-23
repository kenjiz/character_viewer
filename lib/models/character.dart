// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  const Character({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        imageUrl,
      ];

  @override
  bool get stringify => true;

  Character copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
