import 'package:flutter/material.dart';
import '../models/patient_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePatientViewModel extends ChangeNotifier {
  final PatientModel _model = PatientModel();
  Map<String, dynamic> initialPatientData = {};

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
    _model.name = data['nama'] ?? '';
    _model.age = data['umur']?.toString() ?? '';
    _model.gender = data['gender'] ?? 'Male';
    _model.address = data['alamat'] ?? '';
    _model.phoneNumber = data['no_telp'] ?? '';
    _model.email = data['email'] ?? '';

    initialPatientData = Map.from(data);
    
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

  Future<void> updatePatient(BuildContext context, int patientId) async {
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
        "nama": _model.name.isNotEmpty ? _model.name : initialPatientData["nama"],
        "umur": _model.age.isNotEmpty ? _model.age : initialPatientData["umur"],
        "gender": _model.gender.isNotEmpty ? _model.gender : initialPatientData["gender"],
        "alamat": _model.address.isNotEmpty ? _model.address : initialPatientData["alamat"],
        "no_telp": _model.phoneNumber.isNotEmpty ? _model.phoneNumber : initialPatientData["no_telp"],
        "email": _model.email.isNotEmpty ? _model.email : initialPatientData["email"],
      };

      final response = await Dio().put(
        'https://api-antrian-rs.onrender.com/api/table_pasien/$patientId',
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
            content: Text('Patient updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        setError('Failed to update patient data.');
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