class LogsModel {
  LogsModel({
    required this.activity,
    required this.createdAt,
    required this.email,
    required this.role,
  });

  final String activity;
  final DateTime createdAt;
  final String email;
  final String role;

  factory LogsModel.fromJson(Map<String, dynamic> json) => LogsModel(
        activity: json["activity"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? ""),
        email: json["email"] ?? "",
        role: json["role"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "activity": activity,
        "created_at": createdAt,
        "email": email,
        "role": role,
      };
}
