import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HumService extends ChangeNotifier {
  final String _baseUrl = 'sb-129-proj-default-rtdb.firebaseio.com';
  late String  humedad;
  bool isLoadingHum = true;

  HumService() {
    loadProducts();
  }

  Future<String> loadProducts() async {
    print("nueva peticion");
    isLoadingHum  = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/humedad.json');
    final resp = await http.get(url);
    print(resp.body);
    humedad = resp.body.toString();
    //hist = Hum.fromMap(histMap);
    print(humedad);
    isLoadingHum  = false;
    notifyListeners();
    return humedad;
  }
}
