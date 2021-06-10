import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_record/models/resepObat.dart';
import 'package:http/http.dart' as http;

class ResepProvider with ChangeNotifier {
  
  List<ResepObat> resepObat = [];

  Future<void> getResep(context, int idrekammedis) async {
    resepObat.clear();
    final url = Uri.parse("http://192.168.43.2:3000/resepobat");
    final response =
        await http.post(url, body: {"idrekammedis": idrekammedis.toString()});
    final datas = jsonDecode(response.body)['data'];
    for (var data in datas) {
      ResepObat resep = new ResepObat.fromJson(data);
      resepObat.add(resep);
    }
    resepObat = resepObat;
    notifyListeners();
  }
}
