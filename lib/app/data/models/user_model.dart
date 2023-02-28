import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserModel {
  UserModel({
    required this.role,
    required this.email,
    required this.id,
    required this.createdAt,
    required this.pass,
  });

  final String role;
  final String email;
  final String id;
  final DateTime createdAt;
  final String pass;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        pass: json["password"] ?? "",
        role: json["role"] ?? "",
        createdAt: (json["created_at"] as Timestamp).toDate(),
      );
    } catch (e) {
      return UserModel(
        id: "",
        email: "",
        pass: "",
        role: "",
        createdAt: DateTime.now(),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": pass,
        "role": role,
        "created_at": createdAt,
      };
}
