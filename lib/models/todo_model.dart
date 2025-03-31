import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  const TodoModel({
    required this.userID,
    required this.name,
    required this.createdAt,
    this.id,
    this.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int,
      userID: json['user_id'] as String,
      name: json['name'] as String,
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  final int? id;
  final String userID;
  final String name;
  final DateTime? updatedAt;
  final DateTime createdAt;

  TodoModel copyWith({
    int? id,
    String? userID,
    String? name,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userID,
      'name': name,
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, userID, name, updatedAt, createdAt];
}
