import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sb129/models/models.dart';
import 'package:http/http.dart' as http;

class HistTempService extends ChangeNotifier {
  final String _baseUrl = 'sb-129-proj-default-rtdb.firebaseio.com';
  late HistTemp hist;
  bool isLoading = true;

  HistTempService() {
    loadProducts();
  }

  Future<HistTemp> loadProducts() async {
    print("nueva peticion");
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, '/historial.json');
    final resp = await http.get(url);
    print(resp.body);
    final Map<String, dynamic> histMap = json.decode(resp.body);
    hist = HistTemp.fromMap(histMap);
    isLoading = false;
    notifyListeners();
    return hist;
  }
}
