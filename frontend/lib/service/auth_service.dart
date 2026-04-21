import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  /// 🔐 LOGIN
  static Future<bool> login(String username, String password) async {
    print("LOGIN SEND:");
    print("USERNAME: $username");
    print("PASSWORD: $password");

    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username, // ✅ sekarang benar
        "password": password,
      }),
    );

    print("LOGIN STATUS: ${response.statusCode}");
    print("LOGIN BODY: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // ⚠️ kalau belum pakai token di backend
      final token = data['token'] ?? "dummy_token";

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return true;
    } else {
      return false;
    }
  }

  /// 🔑 GET TOKEN
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// 🚪 LOGOUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  /// 📝 REGISTER
  static Future<bool> register(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    print("REGISTER STATUS: ${response.statusCode}");
    print("REGISTER BODY: ${response.body}");

    return response.statusCode == 200;
  }
}