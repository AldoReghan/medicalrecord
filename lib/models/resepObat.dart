class ResepObat{
  final int idresep;
  final String namaObat;
  final int jumlahObat;
  final String keterangan;

  ResepObat({this.idresep, this.namaObat, this.jumlahObat, this.keterangan});

  factory ResepObat.fromJson(Map<String, dynamic> json){
    return ResepObat(
      idresep: json['idresep'] as int ,
      namaObat: json['nama_obat'] as String,
      jumlahObat: json['jumlah'] as int ,
      keterangan: json['keterangan'] as String
    );
  }

}