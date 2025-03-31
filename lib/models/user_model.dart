import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
    this.updatedAt,
    this.lastSignIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print('Name: $json');
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.tryParse(json['updated_at'] as String),
      lastSignIn:
          json['last_sign_in'] == null
              ? null
              : DateTime.tryParse(json['last_sign_in'] as String),
    );
  }

  final String uid;
  final String email;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? lastSignIn;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'last_sign_in': lastSignIn?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastSignIn,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSignIn: lastSignIn ?? this.lastSignIn,
    );
  }

  @override
  List<Object?> get props => [
    uid,
    email,
    name,
    createdAt,
    updatedAt,
    lastSignIn,
  ];
}
