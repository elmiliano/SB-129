import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sb129/models/models.dart';
import 'package:http/http.dart' as http;

class HistTempService extends ChangeNotifier{

  final String _baseUrl = 'sb-129-eab59-default-rtdb.firebaseio.com';
  late HistTemp hist;
  bool isLoading = true;

  HistTempService() {
    this.loadProducts();


  }

  Future<HistTemp> loadProducts() async {
    this.isLoading = true;
    notifyListeners();
    
    final url = Uri.https(_baseUrl,'Historial.json');
    final resp = await http.get(url);

    final Map<String, dynamic> histMap = json.decode(resp.body);
    this.hist = HistTemp.fromMap(histMap);

    this.isLoading = false;
    notifyListeners();
    return this.hist;

  }
}