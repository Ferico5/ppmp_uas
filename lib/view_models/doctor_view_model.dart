import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorViewModel extends ChangeNotifier {
  final DoctorModel _model = DoctorModel();

  DoctorModel get model => _model;

  void setLoading(bool value) {
    _model.isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _model.error = value;
    notifyListeners();
  }

  void setDoctorData(Map<String, dynamic> data) {
    _model.name = data['data']['nama'] ?? '';
    _model.phoneNumber = data['data']['no_telp'] ?? '';
    _model.email = data['data']['email'] ?? '';
    notifyListeners();
  }

  Future<void> fetchDoctorById(int doctorId) async {
    setLoading(true);
    setError(null);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        setError('You are not authenticated. Please log in again.');
        setLoading(false);
        return;
      }

      final response = await Dio().get(
        'http://10.0.2.2:8000/api/table_dokter/$doctorId',
        options: Options(
          headers: {
            'Authorization': 'Token $token', // Gunakan token dari SharedPreferences
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        setDoctorData(response.data);
      } else {
        setError('Failed to fetch doctor data.');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        setError('Error: ${e.response?.data}');
      } else {
        setError('Failed to connect to the server.');
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> delete(BuildContext context) async {
    // TODO: Implement delete logic if needed
    await Future.delayed(const Duration(seconds: 2));
  }
}