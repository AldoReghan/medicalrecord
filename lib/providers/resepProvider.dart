import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_record/models/resepObat.dart';

class ResepProvider with ChangeNotifier{
  ResepObat resepObat = ResepObat();
  bool loading = false;

  getResep(context, int nip) async {
    loading = true;
    // resepObat = await getMedicineReceipt(context, nip);
    loading = false;
    notifyListeners();
  }

}