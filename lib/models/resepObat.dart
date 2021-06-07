class ResepObat{
  final String namaObat;
  final int jumlahObat;
  final String keterangan;

  ResepObat({this.namaObat, this.jumlahObat, this.keterangan});

  factory ResepObat.fromJson(Map<String, dynamic> json){
    return ResepObat(
      namaObat: json['nama_obat'] as String,
      jumlahObat: json['jumlah'] as int ,
      keterangan: json['keterangan'] as String
    );
  }

}