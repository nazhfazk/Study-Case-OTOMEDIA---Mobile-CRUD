class Kontak {
  int? id;
  String nama;
  String noHP;

  Kontak({this.id, required this.nama, required this.noHP});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'no_hp': noHP,
    };
  }

  Kontak.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        nama = data['nama'] ?? '',
        noHP = data['no_hp'] ?? '';
}
