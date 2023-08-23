import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../utils/name_extractor.dart';

const uuid = Uuid();

class CharacterAPIModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  CharacterAPIModel({
    String? id,
    required this.name,
    required this.description,
    required this.imageUrl,
  }) : id = id ?? uuid.v4();

  @override
  List<Object> get props => [
        id,
        name,
        description,
        imageUrl,
      ];

  CharacterAPIModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return CharacterAPIModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool get stringify => true;

  factory CharacterAPIModel.fromMap(Map<String, dynamic> map) {
    return CharacterAPIModel(
      name: NameExtractor.extract(map['Result'] as String),
      description: map['Text'] as String,
      imageUrl: map['Icon']['URL'] as String,
    );
  }
}
