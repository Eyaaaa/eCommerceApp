import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
Future<Map<String, dynamic>> loadSettings() async {
  String jsonString = await rootBundle.loadString('assets/theme.json');
  final jsonResponse = json.decode(jsonString);
  return jsonResponse;
}

