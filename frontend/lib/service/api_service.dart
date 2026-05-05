import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000'; // untuk emulator Android

  /// Ambil daftar item dari API
  static Future<List<dynamic>> getItems(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/items'),
      headers: {
        'Authorization': token,
      },
    );

    return jsonDecode(response.body);
  }

  /// Buat item baru di API
  static Future<bool> createItem(
    String token,
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/items'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode(data),
    );

    // Debugging log
    print("CREATE STATUS: ${response.statusCode}");
    print("CREATE BODY: ${response.body}");

    return response.statusCode == 200;
  }

  /// Update item berdasarkan ID
  static Future<bool> updateItem(
    String token,
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/items/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode(data),
    );

    return response.statusCode == 200;
  }

  /// Hapus item berdasarkan ID
  static Future<bool> deleteItem(String token, int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/items/$id'),
      headers: {
        'Authorization': token,
      },
    );

    return response.statusCode == 200;
  }
}