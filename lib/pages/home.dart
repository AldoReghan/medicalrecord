import 'package:flutter/material.dart';
import 'package:medical_record/components/CardInfo.dart';
import 'package:medical_record/components/CardName.dart';
import 'package:medical_record/login.dart';
import 'package:medical_record/pages/medicalDetails.dart';
import 'package:medical_record/providers/pasienProvider.dart';
import 'package:medical_record/providers/rekamMedisProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

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
  int iduser;

  check() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final int idusers = sharedPreferences.getInt('iduser');
    if (idusers == null) {
      setState(() {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    } else {
      Provider.of<PasienProvider>(context, listen: false)
          .getDataPasien(context, idusers);
      setState(() {
        iduser = idusers;
      });
    }
  }

  Future<void> _refresh() async {
    await check();
  }

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('iduser');
    sharedPreferences.clear();
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
              onPressed: () {
                logout();
              },
            )
          ],
        ),
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(content: Text("Double Click To Exit")),
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: Provider.of<PasienProvider>(context, listen: false)
                      .getDataPasien(context, iduser),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Consumer<PasienProvider>(
                        builder: (context, data, _) {
                      final x = data.pasien[0];
                      return Column(
                        children: [
                          CardName(
                            name: x.namaPasien,
                            nip: x.nip.toString(),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.4,
                            child: FutureBuilder(
                                future: Provider.of<RekamMedisProvider>(context,
                                        listen: false)
                                    .getRekamMedis(context, x.nip),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Consumer<RekamMedisProvider>(
                                      builder: (context, data, _) {
                                    return ListView.builder(
                                        itemCount: data.rekamMedis.length,
                                        itemBuilder: (context, i) {
                                          final file = data.rekamMedis[i];
                                          if (file == null) {
                                            return Center(
                                              child: Text('Rekam Medis kosong'),
                                            );
                                          } else {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MedicalDetails(
                                                              item: file,
                                                            )));
                                              },
                                              child: CardInfo(
                                                tujuan: file.tujuan,
                                                namaDokter: file.namaDokter,
                                                tanggalKedatangan:
                                                    file.tglBerobat,
                                                lokasi: file.lokasi,
                                              ),
                                            );
                                          }
                                        });
                                  });
                                }),
                          )
                        ],
                      );
                    });
                  }),
            ),
          ),
        ));
  }
}
