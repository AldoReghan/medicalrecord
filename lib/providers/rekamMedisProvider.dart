import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_record/models/rekamMedis.dart';

class RekamMedisProvider extends ChangeNotifier {
  List<RekamMedis> rekamMedis;
  List<RekamMedis> get listrekammedis => rekamMedis;

  int idrekammedis = 0;
  int get idRekammedis => idrekammedis;

  set idRekammedis(int id){
    idrekammedis = id;
    notifyListeners();
  }

  set listrekammedis(List<RekamMedis> data) {
    rekamMedis = data;
    idrekammedis = rekamMedis[0].idrekammedis;
    notifyListeners();
  }

  Future<List<RekamMedis>> getRekamMedis(context, int nip) async {
    final url = Uri.parse("http://192.168.43.2:3000/rekammedis");
    final response = await http.post(url, body: {"nip": nip.toString()});
    final res = jsonDecode(response.body)['data'];

    List<RekamMedis> data = [];

    for (var i = 0; i < res.length; i++) {
      var rekammedis = RekamMedis.fromJson(res[i]);
      data.add(rekammedis);
    }

    listrekammedis = data;
    return listrekammedis;
  }
}
