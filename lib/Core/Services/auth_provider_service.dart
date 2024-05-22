import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/Models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoggedIn = false;

  String? _accessToken;
  String? get accessToken => _accessToken;

  UserModel? get user => _user;
  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    _loadUserFromStorage();
  }

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _user = UserModel.fromJson(data);
      _isLoggedIn = true;
      _saveUserToStorage(data);
      _accessToken = data['token'];
      notifyListeners();
    } else {
      throw Exception('Login failed with status code ${response.statusCode}');
    }
  }

  Future<Response> sendrequest(
      String userName, String password, String accessToken) async {
    final userResponse = await http.get(
      Uri.parse('https://dummyjson.com/auth/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    return userResponse;
  }

  Future<void> logout() async {
    _user = null;
    _isLoggedIn = false;
    await _removeUserFromStorage();
    notifyListeners();
  }

  Future<void> _loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (userData != null) {
      final decodedData = jsonDecode(userData);
      _user = UserModel.fromJson(decodedData);
    }
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  Future<void> _saveUserToStorage(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(data));
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> _removeUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }
}
