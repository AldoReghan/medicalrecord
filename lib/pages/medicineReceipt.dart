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
  Future<void> _resfresh() async {
    await Provider.of<ResepProvider>(context, listen: false)
        .getResep(context, widget.idrekammedis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Obat'),
        backgroundColor: Colors.blue[900],
      ),
      body: RefreshIndicator(
        onRefresh: _resfresh,
        child: FutureBuilder(
          future: Provider.of<ResepProvider>(context, listen: false)
              .getResep(context, widget.idrekammedis),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<ResepProvider>(builder: (context, data, _) {
              if (data.resepObat.length < 0) {
                return Center(
                  child: Text('Resep obat tidak ada'),
                );
              } else {
                return ListView.builder(
                    itemCount: data.resepObat.length,
                    itemBuilder: (context, i) {
                      final x = data.resepObat[i];
                      return CardMedicine(
                          namaObat: x.namaObat,
                          jumlah: x.jumlahObat,
                          keterangan: x.keterangan);
                    });
              }
            });
          },
        ),
      ),
    );
  }
}
