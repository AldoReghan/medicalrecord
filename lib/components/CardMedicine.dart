import 'package:flutter/material.dart';

class CardMedicine extends StatelessWidget {
  final String namaObat;
  final int jumlah;
  final String keterangan;

  const CardMedicine({Key key, this.namaObat, this.jumlah, this.keterangan}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  color: Colors.blue.withOpacity(0.5),
                  offset: Offset(0, 6))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16.0, left: 16.0),
              child: Text(namaObat, style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(jumlah.toString()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16),
              child: Text(keterangan),
            ),
          ],
        ),
      ),
    );
  }
}
