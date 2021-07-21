import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_record/models/resepObat.dart';
import 'package:http/http.dart' as http;

class ResepProvider extends ChangeNotifier {
  //set getter
  List<ResepObat> resepObat;
  List<ResepObat> get listResepObat => resepObat;

  bool stats;
  bool get status => stats;

  set status(bool pesan){
    stats = pesan;
    notifyListeners();
  } 

  //set setter
  set listResepObat(List<ResepObat> data) {
    resepObat = data;
    notifyListeners();
  }

  //get data from API
  Future<List<ResepObat>> getResep(context, int idrekammedis) async {
    final url = Uri.parse("http://192.168.43.2:3000/resepobat");
    final response =
        await http.post(url, body: {"idrekammedis": idrekammedis.toString()});

    final res = jsonDecode(response.body)['data'];
    bool error = jsonDecode(response.body)['error'];

    List<ResepObat> data = [];

    if (error == false) {
      for (var i = 0; i < res.length; i++) {
        var resep = new ResepObat.fromJson(res[i]);
        data.add(resep);
      }
    }

    listResepObat = data;
    stats = error;
    return listResepObat;
  }
}
