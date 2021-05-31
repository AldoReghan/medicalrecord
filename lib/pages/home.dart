import 'package:flutter/material.dart';
import 'package:medical_record/components/CardInfo.dart';
import 'package:medical_record/components/CardName.dart';
import 'package:medical_record/pages/medicalDetails.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue[900]),
        title:
            Text('Medical Record', style: TextStyle(color: Colors.blue[900])),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardName(
              name: 'Aldo Reghan Ramadhan',
              np: 191080200193.toString(),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalDetails()));
                    },
                    child: CardInfo()),
                  CardInfo(),
                  CardInfo(),
                  CardInfo()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
