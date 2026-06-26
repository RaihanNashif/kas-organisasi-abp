import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class DashboardService {
  static Future<Map<String, dynamic>> getDashboard() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/dashboard"),
      headers: {
        "Accept": "application/json",
      },
    );

    return jsonDecode(response.body);
  }
}