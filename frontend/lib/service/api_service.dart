import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000'; // untuk emulator Android

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

  /// Buat item baru di API (support upload gambar)
  static Future<bool> createItem(
    String token,
    Map<String, dynamic> data, {
    String? imagePath,
  }) async {
    final uri = Uri.parse('$baseUrl/api/items');
    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = token;

    data.forEach((key, value) {
      if (value != null) request.fields[key] = value.toString();
    });

    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

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

  /// Ambil daftar kategori dari API
  static Future<List<dynamic>> getCategories(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/categories'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return [];
  }

  /// Tambah kategori baru
  static Future<bool> createCategory(String token, String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/categories'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({'name': name}),
    );

    return response.statusCode == 200;
  }
}