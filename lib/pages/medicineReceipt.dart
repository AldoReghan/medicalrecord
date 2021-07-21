import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medical_record/components/CardMedicine.dart';
import 'package:medical_record/models/resepObat.dart';
import 'package:medical_record/providers/resepProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
  List<ResepObat> data = [];

  getDataObat() async {
    data.clear();
    final url = Uri.parse("http://192.168.43.2:3000/resepobat");
    final response = await http
        .post(url, body: {"idrekammedis": widget.idrekammedis.toString()});

    final res = jsonDecode(response.body)['data'];

    for (var item in res) {
      var resep = new ResepObat.fromJson(item);
      print(resep.namaObat);
      setState(() {
        data.add(resep);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ResepProvider resepProvider = Provider.of<ResepProvider>(context);
    resepProvider.getResep(context, widget.idrekammedis);

    return Scaffold(
        appBar: AppBar(
          title: Text('Resep Obat'),
          backgroundColor: Colors.blue[900],
        ),
        body: resepProvider.status == true
            ? Center(
                child: Text("Resep Obat Kosong"),
              )
            : ListView.builder(
                itemCount: resepProvider.listResepObat.length,
                itemBuilder: (context, i) {
                  final x = resepProvider.listResepObat[i];
                  return CardMedicine(
                    namaObat: x.namaObat,
                    jumlah: x.jumlahObat,
                    keterangan: x.keterangan,
                  );
                }));
  }
}
