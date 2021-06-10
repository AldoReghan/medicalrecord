import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_record/models/pasien.dart';

class PasienProvider with ChangeNotifier{

  List<Pasien> pasien = [];

  Future<void> getDataPasien(context, int iduser) async {
    pasien.clear();
    final url = Uri.parse("http://192.168.43.2:3000/pasien");
    final response = await http.post(url, body: {"iduser": iduser.toString()});
    final data = jsonDecode(response.body)['data'];
    for (var item in data) {
      Pasien pasiens = Pasien.fromJson(item);
      pasien.add(pasiens);
    }
    notifyListeners();
  }
}