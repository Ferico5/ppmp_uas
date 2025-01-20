import 'package:flutter/material.dart';
import '../models/patient_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePatientViewModel extends ChangeNotifier {
  final PatientModel _model = PatientModel();

  PatientModel get model => _model;

  void setName(String value) {
    _model.name = value;
    notifyListeners();
  }

  void setAge(String value) {
    _model.age = value;
    notifyListeners();
  }

  void setGender(String value) {
    _model.gender = value;
    notifyListeners();
  }

  void setAddress(String value) {
    _model.address = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _model.phoneNumber = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _model.email = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _model.isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _model.error = value;
    notifyListeners();
  }

  void setPatientData(Map<String, dynamic> data) {
    _model.name = data['name'] ?? '';
    _model.age = data['age']?.toString() ?? '';
    _model.gender = data['gender'] ?? 'Male';
    _model.address = data['address'] ?? '';
    _model.phoneNumber = data['phoneNumber'] ?? '';
    _model.email = data['email'] ?? '';
    notifyListeners();
  }

  Future<void> fetchPatientById(int patientId) async {
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
        'https://api-antrian-rs.onrender.com/api/table_pasien/$patientId',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        setPatientData(response.data);
      } else {
        setError('Failed to fetch patient data.');
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

  Future<void> update(BuildContext context) async {
    setLoading(true);
    setError(null);

    if (_model.name.isEmpty ||
        _model.age.isEmpty ||
        _model.address.isEmpty ||
        _model.phoneNumber.isEmpty ||
        _model.email.isEmpty) {
      setError("Please fill all the fields");
      setLoading(false);
      return;
    }

    // Simulate an async update operation (e.g., API call)
    await Future.delayed(const Duration(seconds: 2));

    setLoading(false);
    Navigator.pop(context);
  }
}