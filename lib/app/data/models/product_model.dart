class ProductModel {
  ProductModel({
    required this.harga,
    required this.namaProduk,
    required this.id,
  });

  final int harga;
  final String namaProduk;
  final String id;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? "",
        namaProduk: json["nama_produk"] ?? "",
        harga: json["harga"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_produk": namaProduk,
        "harga": harga,
      };
}
