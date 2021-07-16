// import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:medical_record/components/CardMedicine.dart';
import 'package:medical_record/providers/resepProvider.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    final ResepProvider resepProvider = Provider.of<ResepProvider>(context);
    resepProvider.getResep(context, widget.idrekammedis);

    return Scaffold(
        appBar: AppBar(
          title: Text('Resep Obat'),
          backgroundColor: Colors.blue[900],
        ),
        body: resepProvider.listResepObat == null
            ? Center(
                child: CircularProgressIndicator(),
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
