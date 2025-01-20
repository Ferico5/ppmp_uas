import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDoctorViewModel extends ChangeNotifier {
  final DoctorModel _model = DoctorModel();
  Map<String, dynamic> initialDoctorData = {};

  DoctorModel get model => _model;

  void setName(String value) {
    _model.name = value;
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

  void setDoctorData(Map<String, dynamic> data) {
    _model.name = data['nama'] ?? '';
    _model.phoneNumber = data['no_telp'] ?? '';
    _model.email = data['email'] ?? '';

    initialDoctorData = Map.from(data);
    
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
        'https://api-antrian-rs.onrender.com/api/table_dokter/$doctorId',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
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

  Future<void> updateDoctor(BuildContext context, int doctorId) async {
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

      final data = {
        "nama": _model.name.isNotEmpty ? _model.name : initialDoctorData["nama"],
        "no_telp": _model.phoneNumber.isNotEmpty ? _model.phoneNumber : initialDoctorData["no_telp"],
        "email": _model.email.isNotEmpty ? _model.email : initialDoctorData["email"],
      };

      final response = await Dio().put(
        'https://api-antrian-rs.onrender.com/api/table_dokter/$doctorId',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json',
          },
        ),
        data: data,
      );

      if (response.statusCode == 200 && response.data != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Doctor updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        setError('Failed to update doctor data.');
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
}