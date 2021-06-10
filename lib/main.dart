import 'package:flutter/material.dart';
import 'package:medical_record/providers/pasienProvider.dart';
import 'package:medical_record/providers/rekamMedisProvider.dart';
import 'package:medical_record/providers/resepProvider.dart';
import 'package:medical_record/splashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ResepProvider(),),
        ChangeNotifierProvider(create: (_) => PasienProvider(),),
        ChangeNotifierProvider(create: (_) => RekamMedisProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'medical record',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
