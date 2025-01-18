import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient_model.dart';
import '../view_models/show_detail_patients_view_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientViewModel extends ChangeNotifier {
  final PatientModel _model = PatientModel();

  PatientModel get model => _model;

  void setLoading(bool value) {
    _model.isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _model.error = value;
    notifyListeners();
  }

  void setPatientData(Map<String, dynamic> data) {
    _model.name = data['data']['nama'] ?? '';
    _model.age = data['data']['umur']?.toString() ?? '';
    _model.gender = data['data']['gender'] ?? '';
    _model.address = data['data']['alamat'] ?? '';
    _model.phoneNumber = data['data']['no_telp'] ?? '';
    _model.email = data['data']['email'] ?? '';
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
        'http://10.0.2.2:8000/api/table_pasien/$patientId',
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

  Future<void> deletePatientById(BuildContext context, int patientId) async {
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

      final response = await Dio().delete(
        'http://10.0.2.2:8000/api/table_pasien/$patientId',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        Provider.of<ShowDetailPatientsViewModel>(context, listen: false).model.patients.removeWhere((patient) => patient['id'] == patientId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Patient deleted successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setError('Failed to delete patient.');
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