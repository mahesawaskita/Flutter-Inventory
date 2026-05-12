import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  // ── ITEMS ────────────────────────────────────────────────────────────────

  static Future<List<dynamic>> getItems(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/items'),
        headers: {'Authorization': token},
      );
      if (response.statusCode == 200) return jsonDecode(response.body);
      return [];
    } catch (_) {
      return [];
    }
  }

  static Future<bool> createItem(
    String token,
    Map<String, dynamic> data, {
    String? imagePath,
  }) async {
    try {
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
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> updateItem(String token, int id, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/items/$id'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(data),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> deleteItem(String token, int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/items/$id'),
        headers: {'Authorization': token},
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // ── CATEGORIES ───────────────────────────────────────────────────────────

  static Future<List<dynamic>> getCategories(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/categories'),
        headers: {'Authorization': token},
      );
      if (response.statusCode == 200) return jsonDecode(response.body);
      return [];
    } catch (_) {
      return [];
    }
  }

  static Future<bool> createCategory(String token, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/categories'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode({'name': name}),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // ── LOANS ────────────────────────────────────────────────────────────────

  /// Ambil semua peminjaman (admin)
  static Future<List<dynamic>> getAllLoans(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/loans'),
        headers: {'Authorization': token},
      );
      if (response.statusCode == 200) return jsonDecode(response.body);
      return [];
    } catch (_) {
      return [];
    }
  }

  /// Ambil peminjaman milik user yang login
  static Future<List<dynamic>> getMyLoans(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/loans/my'),
        headers: {'Authorization': token},
      );
      if (response.statusCode == 200) return jsonDecode(response.body);
      return [];
    } catch (_) {
      return [];
    }
  }

  /// Buat peminjaman baru
  static Future<Map<String, dynamic>> createLoan(
      String token, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/loans'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(data),
      );
      final body = jsonDecode(response.body);
      return {
        'success': response.statusCode == 200,
        'message': body['message'] ?? 'Error',
      };
    } catch (e) {
      return {'success': false, 'message': 'Tidak dapat terhubung ke server'};
    }
  }

  /// Kembalikan barang
  static Future<Map<String, dynamic>> returnLoan(String token, int loanId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/loans/$loanId/return'),
        headers: {'Authorization': token},
      );
      final body = jsonDecode(response.body);
      return {
        'success': response.statusCode == 200,
        'message': body['message'] ?? 'Error',
      };
    } catch (e) {
      return {'success': false, 'message': 'Tidak dapat terhubung ke server'};
    }
  }
}
