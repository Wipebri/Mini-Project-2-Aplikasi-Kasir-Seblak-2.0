class Topping {
  final int? id;
  final String nama;
  final int harga;
  int stok;

  Topping({this.id, required this.nama, required this.harga, required this.stok});

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
      id: json['id'],
      nama: json['nama'] ?? '',
      harga: json['harga'] ?? 0,
      stok: json['stok'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nama': nama,
      'harga': harga,
      'stok': stok,
    };
  }
}

class ItemKeranjang {
  final Topping topping;
  int qty;

  ItemKeranjang({required this.topping, required this.qty});
}