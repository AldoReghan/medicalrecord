import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_record/components/CardInfo.dart';
import 'package:medical_record/components/CardName.dart';
import 'package:medical_record/login.dart';
import 'package:medical_record/models/rekamMedis.dart';
import 'package:medical_record/pages/Profile.dart';
import 'package:medical_record/pages/medicalDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  final int nip;

  const HomePage({Key key, this.nip}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String namaPasien;
  int nip;

  List<RekamMedis> rekamMedis = [];

  check() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final int iduser = sharedPreferences.getInt('iduser');
    if (iduser == null) {
      setState(() {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    } else {
      getDataPasien();
    }
  }

  Future<void> getDataPasien() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final int iduser = sharedPreferences.getInt('iduser');
    final url = Uri.parse("http://192.168.43.2:3000/pasien");
    final response = await http.post(url, body: {"iduser": iduser.toString()});
    final data = jsonDecode(response.body)['data'][0];
    setState(() {
      namaPasien = data['nama_pasien'];
      nip = data['nip'] == null ? "" : data['nip'];
      getRekamMedis(nip);
    });
  }

  getRekamMedis(int nomor) async {
    rekamMedis.clear();
    final url = Uri.parse("http://192.168.43.2:3000/rekammedis");
    final response = await http.post(url, body: {"nip": nomor.toString()});
    final status = jsonDecode(response.body)['status'];
    if (status == 200) {
      final datas = jsonDecode(response.body)['data'];
      for (var data in datas) {
        RekamMedis rekammedis = RekamMedis.fromJson(data);
        rekamMedis.add(rekammedis);
      }
      setState(() {
        return rekamMedis;
      });
    }
  }

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('iduser');
    sharedPreferences.clear();
    // sharedPreferences.commit();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    if (rekamMedis == null) {
      return CircularProgressIndicator();
    } else {
      return RefreshIndicator(
        onRefresh: getDataPasien,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.blue[900]),
            title: Text('Medical Record',
                style: TextStyle(color: Colors.blue[900])),
            elevation: 0.0,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  logout();
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: CardName(
                    name: namaPasien == null ? "" : namaPasien,
                    np: nip == null ? "" : nip.toString(),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: ListView.builder(
                    itemCount: rekamMedis.length,
                    itemBuilder: (context, i) {
                      final data = rekamMedis[i];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicalDetails(
                                        item: data,
                                      )));
                        },
                        child: CardInfo(
                          tujuan: data.tujuan,
                          namaDokter: data.namaDokter,
                          tanggalKedatangan: data.tglBerobat,
                          lokasi: data.lokasi,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
