class Sepeda {
  int? id;
  String? jenis;
  String? brand;
  String? model;
  String? harga;
  String? keterangan;

  Sepeda({
    this.id,
    this.jenis,
    this.brand,
    this.model,
    this.harga,
    this.keterangan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jenis': jenis,
      'brand': brand,
      'model': model,
      'harga': harga,
      'keterangan': keterangan,
    };
  }
}
