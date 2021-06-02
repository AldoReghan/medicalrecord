import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_record/components/CardMedicine.dart';
import 'package:medical_record/models/resepObat.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Receipt',
      home: MedicineReceipt(),
    );
  }
}

class MedicineReceipt extends StatefulWidget {
  final int idrekammedis;

  const MedicineReceipt({Key key, this.idrekammedis}) : super(key: key);
  @override
  _MedicineReceiptState createState() => _MedicineReceiptState();
}

class _MedicineReceiptState extends State<MedicineReceipt> {
  List<ResepObat> resepObat = [];

  getMedicineReceipt() async {
    resepObat.clear();
    final url = Uri.parse("http://192.168.43.2:3000/resepobat");
    final response = await http
        .post(url, body: {"idrekammedis": widget.idrekammedis.toString()});
    final datas = jsonDecode(response.body)['data'];
    for (var data in datas) {
      ResepObat resepobat = ResepObat(
          namaObat: data['nama_obat'],
          jumlahObat: data['jumlah'],
          keterangan: data['keterangan']);
      resepObat.add(resepobat);
    }
    setState(() {
      return resepObat;
    });
  }

  @override
  void initState() {
    super.initState();
    getMedicineReceipt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Obat'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: resepObat.length,
              itemBuilder: (context, index) {
                final x = resepObat[index];
                return CardMedicine(
                  namaObat: x.namaObat,
                  jumlah: x.jumlahObat,
                  keterangan: x.keterangan,
                );
              })),
    );
  }
}
