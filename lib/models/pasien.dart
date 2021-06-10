class Pasien{
  final int iduser;
  final int nip;
  final String namaDokter;
  final String namaPasien;

  Pasien({this.iduser, this.nip, this.namaDokter, this.namaPasien});

  factory Pasien.fromJson(Map<String, dynamic> data){
    return Pasien(
      iduser: data['iduser'],
      nip: data['nip'],
      namaDokter: data['nama_dokter'],
      namaPasien: data['nama_pasien']
    );
  }
}