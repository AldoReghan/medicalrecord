import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Information',
      home: CardInfo(),
    );
  }
}

class CardInfo extends StatefulWidget {

  final String namaDokter;
  final tanggalKedatangan;
  final lokasi;
  final tujuan;

  const CardInfo({Key key, this.namaDokter, this.tanggalKedatangan, this.lokasi, this.tujuan}) : super(key: key);

  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 7,
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(0, 6))
              ]),
          child: Column(
            children: [
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                    ),
                  color: Colors.blue,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:4.0),
                      child: Text('Periksa',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.person, size: 30, color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text('Dr. Aldo Reghan Ramadhan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 30, color: Colors.grey,),
                        SizedBox(width: 10,),
                        Text('20 Januari 2020',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 30, color: Colors.grey,),
                        SizedBox(width: 10,),
                        Text('Faskes 1, Sidoarjo',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),)
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
          ),
    );
  }
}
