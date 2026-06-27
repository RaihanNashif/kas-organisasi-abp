import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class UserService {
  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/users"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }
}