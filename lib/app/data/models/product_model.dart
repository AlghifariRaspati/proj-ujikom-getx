import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  ProductModel(
      {required this.harga,
      required this.namaProduk,
      required this.id,
      required this.createdAt});

  final int harga;
  final String namaProduk;
  final String id;
  final DateTime createdAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? "",
        namaProduk: json["nama_produk"] ?? "",
        harga: json["harga"] ?? 0,
        createdAt: (json["created_at"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_produk": namaProduk,
        "harga": harga,
        "created_at": createdAt,
      };
}
