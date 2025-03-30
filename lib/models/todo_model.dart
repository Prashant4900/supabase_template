import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  const TodoModel({
    required this.id,
    required this.userID,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
  });

  factory TodoModel.fromDocSnapshot(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return TodoModel(
      id: doc.id,
      userID: data['user_id'] as String,
      name: data['name'] as String,
      updatedAt: DateTime.parse(data['updated_at'] as String),
      createdAt: DateTime.parse(data['created_at'] as String),
    );
  }

  final String id;
  final String userID;
  final String name;
  final DateTime updatedAt;
  final DateTime createdAt;

  TodoModel copyWith({
    String? id,
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

  Map<String, String> toJson() {
    return {
      'id': id,
      'user_id': userID,
      'name': name,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, userID, name, updatedAt, createdAt];
}
