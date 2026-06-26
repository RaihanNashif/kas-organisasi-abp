import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class UserService {
  // ==========================
  // GET DATA ANGGOTA (USERS)
  // ==========================
  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/users"),
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "success") {
        return data["data"];
      }
      throw Exception(data["message"] ?? "Gagal mengambil data anggota");
    } else {
      throw Exception("Gagal mengambil data anggota");
    }
  }

  // ==========================
  // TAMBAH ANGGOTA (USER)
  // ==========================
  static Future<bool> tambahUser({
    required String nama,
    required String username,
    required String password,
    required String role,
    required String alamat,
    required String noHp,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/users"),
      headers: {
        "Accept": "application/json",
      },
      body: {
        "nama": nama,
        "username": username,
        "password": password,
        "role": role,
        "alamat": alamat,
        "no_hp": noHp,
      },
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }

  // ==========================
  // EDIT ANGGOTA (USER)
  // ==========================
  static Future<bool> updateUser({
    required String idUsers,
    required String nama,
    required String username,
    String? password,
    required String role,
    required String alamat,
    required String noHp,
  }) async {
    final body = {
      "nama": nama,
      "username": username,
      "role": role,
      "alamat": alamat,
      "no_hp": noHp,
    };

    if (password != null && password.isNotEmpty) {
      body["password"] = password;
    }

    final response = await http.put(
      Uri.parse("${ApiConfig.baseUrl}/users/$idUsers"),
      headers: {
        "Accept": "application/json",
      },
      body: body,
    );

    return response.statusCode == 200;
  }

  // ==========================
  // HAPUS ANGGOTA (USER)
  // ==========================
  static Future<bool> hapusUser(String idUsers) async {
    final response = await http.delete(
      Uri.parse("${ApiConfig.baseUrl}/users/$idUsers"),
      headers: {
        "Accept": "application/json",
      },
    );

    return response.statusCode == 200;
  }
}
