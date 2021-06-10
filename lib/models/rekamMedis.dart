class RekamMedis {
  final int idrekammedis;
  final int nip;
  final int nid;
  final String namaDokter;
  final tglBerobat;
  final int idfaskes;
  final String tujuan;
  final String lokasi;
  final String keluhan;
  final String diagnosa;
  final String catatan;
  final String tekananDarah;

  RekamMedis(
      {this.tekananDarah,
      this.idrekammedis,
      this.nip,
      this.nid,
      this.namaDokter,
      this.tglBerobat,
      this.idfaskes,
      this.tujuan,
      this.lokasi,
      this.keluhan,
      this.diagnosa,
      this.catatan});

  factory RekamMedis.fromJson(Map<String, dynamic> data) {
    return RekamMedis(
        idrekammedis: data['idrekammedis'],
        nip: data['nip'],
        nid: data['nid'],
        idfaskes: data['idfaskes'],
        namaDokter: data['nama_dokter'],
        tujuan: data['tujuan'],
        keluhan: data['keluhan'],
        diagnosa: data['diagnosa'],
        catatan: data['catatan'],
        lokasi: data['nama_faskes'],
        tekananDarah: data['tekanan_darah'],
        tglBerobat: data['tgl_berobat']);
  }
}
