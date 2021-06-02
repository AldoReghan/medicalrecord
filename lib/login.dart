import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medical_record/pages/home.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  login(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (username == "" || password == "") {
      print("username password harus diisi");
    } else {
      final url = Uri.parse("http://192.168.43.2:3000/login");
      final response = await http
          .post(url, body: {"username": username, "password": password});
      final data = jsonDecode(response.body)['data'][0];
      final status = jsonDecode(response.body)['status'];
      final int iduser = data['iduser'];
      if (status == 200) {
        sharedPreferences.setInt('iduser', iduser);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _key,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/img/logo.png",
                height: 100,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue)),
                  child: TextFormField(
                    controller: usernameController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'NIP',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue)),
                  child: TextFormField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: GestureDetector(
                  onTap: () {
                    login(usernameController.text, passwordController.text);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
