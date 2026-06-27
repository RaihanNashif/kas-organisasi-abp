import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class PengeluaranService {
  // GET
  static Future<List<dynamic>> getPengeluaran() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/pengeluaran"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }

  // POST
  static Future<bool> tambahPengeluaran({
    required String tanggal,
    required String keperluan,
    required String jumlah,
    required String keterangan,
    required String idUsers,
    required String inputBy,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/pengeluaran"),
      headers: {
        "Accept": "application/json",
      },
      body: {
        "tanggal": tanggal,
        "keperluan": keperluan,
        "jumlah": jumlah,
        "keterangan": keterangan,
        "id_users": idUsers,
        "input_by": inputBy,
      },
    );

    return response.statusCode == 200;
  }

  // PUT
  static Future<bool> editPengeluaran({
    required int id,
    required String tanggal,
    required String keperluan,
    required String jumlah,
    required String keterangan,
    required String idUsers,
    required String inputBy,
  }) async {
    final response = await http.put(
      Uri.parse("${ApiConfig.baseUrl}/pengeluaran/$id"),
      headers: {
        "Accept": "application/json",
      },
      body: {
        "tanggal": tanggal,
        "keperluan": keperluan,
        "jumlah": jumlah,
        "keterangan": keterangan,
        "id_users": idUsers,
        "input_by": inputBy,
      },
    );

    return response.statusCode == 200;
  }

  // DELETE
  static Future<bool> hapusPengeluaran(int id) async {
    final response = await http.delete(
      Uri.parse("${ApiConfig.baseUrl}/pengeluaran/$id"),
    );

    return response.statusCode == 200;
  }
}