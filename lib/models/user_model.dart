import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.userID,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.lastSignIn,
  });

  factory UserModel.fromDocSnapshot(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return UserModel(
      userID: doc.id,
      email: data['email'] as String,
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: DateTime.parse(data['updated_at'] as String),
      lastSignIn: DateTime.parse(data['last_sign_in'] as String),
    );
  }

  final String userID;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastSignIn;

  UserModel copyWith({
    String? userID,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSignIn,
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSignIn: lastSignIn ?? this.lastSignIn,
    );
  }

  Map<String, String> toJson() {
    return {
      'user_id': userID,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'last_sign_in': lastSignIn.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [userID, email, createdAt, updatedAt, lastSignIn];
}
