import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class LaporanService {

  static Future<List<dynamic>> getLaporan() async {

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/laporan"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }

  static Future<bool> generateLaporan({
    required String bulan,
    required String tahun,
    required String idUsers,
  }) async {

    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/generate-laporan"),

      headers: {
        "Accept": "application/json",
      },

      body: {
        "bulan": bulan,
        "tahun": tahun,
        "id_users": idUsers,
      },
    );

    return response.statusCode == 200;

  }

}