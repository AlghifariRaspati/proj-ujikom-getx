import 'package:intl/intl.dart';

class UserModel {
  UserModel({
    required this.role,
    required this.email,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.pass,
  });

  final String role;
  final String email;
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String pass;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        pass: json["password"] ?? "",
        role: json["role"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? ""),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": pass,
        "role": role,
        "created_at": DateFormat("yyyy-MM-dd, HH:mm:ss").format(createdAt),
        "updated_at": updatedAt != null
            ? DateFormat("yyyy-MM-dd, HH:mm:ss").format(updatedAt!)
            : null,
      };

  String get formattedUpdatedAt => updatedAt != null
      ? DateFormat("yyyy-MM-dd, HH:mm:ss").format(updatedAt!)
      : "";

  String get formattedCreatedAt =>
      DateFormat("yyyy-MM-dd, HH:mm:ss").format(createdAt);
}
