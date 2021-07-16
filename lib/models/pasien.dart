class Pasien {
  final int iduser;
  final int nip;
  final String namaPasien;

  Pasien({this.iduser, this.nip,this.namaPasien});

  factory Pasien.fromJson(Map<String, dynamic> data) {
    return Pasien(
        iduser: data['iduser'],
        nip: data['nip'],
        namaPasien: data['nama_pasien']);
  }
}
