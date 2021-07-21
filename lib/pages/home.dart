import 'package:flutter/material.dart';
import 'package:medical_record/components/CardInfo.dart';
import 'package:medical_record/components/CardName.dart';
import 'package:medical_record/login.dart';
import 'package:medical_record/pages/medicalDetails.dart';
import 'package:medical_record/providers/pasienProvider.dart';
import 'package:medical_record/providers/rekamMedisProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:double_back_to_close_app/double_back_to_close_app.dart';

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
  bool isLogin;
  SharedPreferences sharedPreferences;

  check() async {
    sharedPreferences = await SharedPreferences.getInstance();
    iduser = sharedPreferences.getInt('iduser');
    if (iduser == null) {
      print("iduser nya null");
      setState(() {
        isLogin = false;
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    } else {
      setState(() {
        isLogin = true;
      });
    }
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
    final PasienProvider pasienProvider = Provider.of<PasienProvider>(context);
    pasienProvider.getDataPasien(context, iduser);

    final RekamMedisProvider rekamMedisProvider =
        Provider.of<RekamMedisProvider>(context);
    rekamMedisProvider.getRekamMedis(context, pasienProvider.nipPasien);

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
        body: pasienProvider.listpasien != null &&
                rekamMedisProvider.listrekammedis != null
            ? SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    CardName(
                      name: '${pasienProvider.listpasien[0].namaPasien}',
                      nip: '${pasienProvider.listpasien[0].nip}',
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: rekamMedisProvider.listrekammedis.length,
                          itemBuilder: (context, i) {
                            final x = rekamMedisProvider.listrekammedis[i];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MedicalDetails(
                                              item: x,
                                            )));
                              },
                              child: CardInfo(
                                tujuan: x.tujuan,
                                namaDokter: x.namaDokter,
                                tanggalKedatangan: x.tglBerobat,
                                lokasi: x.lokasi,
                              ),
                            );
                          }),
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
