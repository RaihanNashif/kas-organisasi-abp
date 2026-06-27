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
  print(response.statusCode);
  print(response.body);

  return response.statusCode == 200;

  }

  // ==========================
  // EDIT PEMASUKAN
  // ==========================
  static Future<bool> editPemasukan({

    required int id,
    required String tanggal,
    required String sumber,
    required String jumlah,
    required String keterangan,
    required String idUsers,
    required String inputBy,

  }) async {

    final response = await http.put(

      Uri.parse("${ApiConfig.baseUrl}/pemasukan/$id"),

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

  // ==========================
  // HAPUS PEMASUKAN
  // ==========================
  static Future<bool> hapusPemasukan(int id) async {

    final response = await http.delete(
      Uri.parse("${ApiConfig.baseUrl}/pemasukan/$id"),
    );

    return response.statusCode == 200;

  }

}