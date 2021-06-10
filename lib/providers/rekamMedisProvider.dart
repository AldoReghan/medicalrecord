import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_record/models/rekamMedis.dart';

class RekamMedisProvider with ChangeNotifier{

  List<RekamMedis> rekamMedis = [];

  Future<void> getRekamMedis(context, int nip) async {
    rekamMedis.clear();
    final url = Uri.parse("http://192.168.43.2:3000/rekammedis");
    final response = await http.post(url, body: {"nip": nip.toString()});
    final status = jsonDecode(response.body)['status'];
    if (status == 200) {
      final datas = jsonDecode(response.body)['data'];
      for (var data in datas) {
        RekamMedis rekammedis = RekamMedis.fromJson(data);
        rekamMedis.add(rekammedis);
      }
    }
    notifyListeners();
  }
}