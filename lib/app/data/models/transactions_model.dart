import 'package:cloud_firestore/cloud_firestore.dart';

class TransLogsModel {
  TransLogsModel({
    required this.berat,
    required this.hargaProduk,
    required this.id,
    required this.namaPelanggan,
    required this.namaProduk,
    required this.nomorTelepon,
    required this.nomorUnik,
    required this.totalHarga,
    required this.uangBayar,
    required this.activity,
    required this.createdAt,
    required this.email,
    required this.role,
  });

  final int berat;
  final int hargaProduk;
  final String id;
  final String namaPelanggan;
  final String namaProduk;
  final int nomorTelepon;
  final int nomorUnik;
  final int totalHarga;
  final int uangBayar;
  final String activity;
  final DateTime createdAt;
  final String email;
  final String role;

  factory TransLogsModel.fromJson(Map<String, dynamic> json) => TransLogsModel(
        berat: json["berat"] ?? 0,
        hargaProduk: json["harga_produk"] ?? 0,
        id: json["id"] ?? "",
        namaPelanggan: json["nama_pelanggan"] ?? "",
        namaProduk: json["nama_produk"] ?? "",
        nomorTelepon: json["nomor_telepon"] ?? 0,
        nomorUnik: json["nomor_unik"] ?? 0,
        totalHarga: json["total_harga"] ?? 0,
        uangBayar: json["uang_bayar"] ?? 0,
        activity: json["activity"] ?? "",
        createdAt: (json["created_at"] as Timestamp).toDate(),
        email: json["email_kasir"] ?? "",
        role: json["role"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "berat": berat,
        "harga_produk": hargaProduk,
        "id": id,
        "nama_pelanggan": namaPelanggan,
        "nama_produk": namaProduk,
        "nomor_telepon": nomorTelepon,
        "nomor_unik": nomorUnik,
        "total_harga": totalHarga,
        "uang_bayar": uangBayar,
        "activity": activity,
        "created_at": createdAt,
        "email_kasir": email,
        "role": role,
      };
}
