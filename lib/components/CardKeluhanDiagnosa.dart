import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Keluhan Diagnosa',
      home: CardKeluhanDiagnosa(),
    );
  }
}

class CardKeluhanDiagnosa extends StatefulWidget {

  final String title;
  final String deskripsi;

  const CardKeluhanDiagnosa({Key key, this.title, this.deskripsi}) : super(key: key);

  @override
  _CardKeluhanDiagnosaState createState() => _CardKeluhanDiagnosaState();
}

class _CardKeluhanDiagnosaState extends State<CardKeluhanDiagnosa> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(0, 6))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.deskripsi,
            ),
          ],
        ),
      ),
    );
  }
}
