import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_record/models/pasien.dart';

class PasienProvider extends ChangeNotifier{

  List<Pasien> pasien = [];
  List<Pasien> get listpasien => pasien;

  int nip = 0;
  int get nipPasien => nip;

  set listpasien(List<Pasien> item){
    pasien = item;
    nip = pasien[0].nip;
    notifyListeners();
  }

  set nipPasien(int nomor){
    nip = nomor;
    notifyListeners();
  }


  Future<List<Pasien>> getDataPasien(context, int iduser) async {
    final url = Uri.parse("http://192.168.43.2:3000/pasien");
    final response = await http.post(url, body: {"iduser": iduser.toString()});
    final res = jsonDecode(response.body)['data'];

    List<Pasien> data =[];

    for (var i = 0; i < res.length; i++) {
      var pasiens = Pasien.fromJson(res[i]);
      data.add(pasiens);
    }

    listpasien = data;
    return listpasien;
  }
}