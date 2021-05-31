import 'package:flutter/material.dart';
import 'package:medical_record/components/CardMedicine.dart';

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
  @override
  _MedicineReceiptState createState() => _MedicineReceiptState();
}

class _MedicineReceiptState extends State<MedicineReceipt> {
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
      child: ListView(
        children: [
          CardMedicine()
        ],
      ),
    ),
    );
  }
}