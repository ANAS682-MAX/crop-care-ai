import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/scan_result.dart';

class ApiService {
  static const String baseUrl = 'http://YOUR_SERVER_IP:5000/api';

  final String? token;

  ApiService({this.token});

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  // Auth
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: _headers,
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    return jsonDecode(res.body);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );
    return jsonDecode(res.body);
  }

  // Scans
  Future<void> syncScan(ScanResult scan, File imageFile) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/scans'));
    request.headers.addAll({'Authorization': 'Bearer $token'});
    request.fields['data'] = jsonEncode(scan.toJson());
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    await request.send();
  }

  Future<List<dynamic>> getScans() async {
    final res = await http.get(Uri.parse('$baseUrl/scans'), headers: _headers);
    return jsonDecode(res.body);
  }

  // Diseases
  Future<List<dynamic>> getDiseases() async {
    final res = await http.get(Uri.parse('$baseUrl/diseases'), headers: _headers);
    return jsonDecode(res.body);
  }
}
