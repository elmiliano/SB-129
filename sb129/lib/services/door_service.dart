import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoorService extends ChangeNotifier {
  final String _baseUrl = 'sb-129-proj-default-rtdb.firebaseio.com';
  late bool door;
  late String doorStr;
  bool isLoadingdoor = true;

  DoorService() {
    loadProducts();
  }

  Future<bool> loadProducts() async {
    print("nueva peticion");
    isLoadingdoor  = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/puerta.json');
    final resp = await http.get(url);
    print(resp.body);
    doorStr = resp.body.toString();
    door = doorStr == 'true';
    print(door);
    isLoadingdoor  = false;
    notifyListeners();
    return door;
  }
}
