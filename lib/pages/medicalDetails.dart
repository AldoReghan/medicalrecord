import 'package:flutter/material.dart';
import 'package:medical_record/components/CardDetail.dart';
import 'package:medical_record/components/CardKeluhanDiagnosa.dart';
import 'package:medical_record/pages/medicineReceipt.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Details',
      home: MedicalDetails(),
    );
  }
}

class MedicalDetails extends StatefulWidget {
  @override
  _MedicalDetailsState createState() => _MedicalDetailsState();
}

class _MedicalDetailsState extends State<MedicalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Details'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardDetail(),
                  SizedBox(
                    height: 20,
                  ),
                  CardDetail(),
                  SizedBox(
                    height: 20,
                  ),
                  CardKeluhanDiagnosa(
                    title: 'Keluhan',
                    deskripsi:
                        "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CardKeluhanDiagnosa(
                    title: 'Diagnosa',
                    deskripsi:
                        "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicineReceipt()));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusDirectional.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7,
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(0, 6))
                            ]),
                        child: Center(
                          child: Text(
                            'Lihat Resep Obat',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
