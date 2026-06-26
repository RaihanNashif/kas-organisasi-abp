import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class PemasukanService {

  // ==========================
  // GET DATA PEMASUKAN
  // ==========================
  static Future<List<dynamic>> getPemasukan() async {

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/pemasukan"),
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Gagal mengambil data pemasukan");
    }
  }

  // ==========================
  // TAMBAH PEMASUKAN
  // ==========================
  static Future<bool> tambahPemasukan({

    required String tanggal,
    required String sumber,
    required String jumlah,
    required String keterangan,
    required String idUsers,
    required String inputBy,

  }) async {

    final response = await http.post(

      Uri.parse("${ApiConfig.baseUrl}/pemasukan"),

      headers: {
        "Accept": "application/json",
      },

      body: {

        "tanggal": tanggal,
        "sumber": sumber,
        "jumlah": jumlah,
        "keterangan": keterangan,
        "id_users": idUsers,
        "input_by": inputBy,

      },

    );

    return response.statusCode == 200;

  }

}