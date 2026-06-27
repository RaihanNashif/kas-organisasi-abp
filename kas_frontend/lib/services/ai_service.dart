import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AIService {
  static Future<Map<String, dynamic>> getAnalisis() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/ai-analisis"),
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Gagal mengambil analisis AI");
  }
}