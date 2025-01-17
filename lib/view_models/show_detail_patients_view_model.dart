import 'package:flutter/material.dart';
import '../models/show_detail_patients_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDetailPatientsViewModel extends ChangeNotifier {
  final ShowDetailPatientsModel _model = ShowDetailPatientsModel();

  ShowDetailPatientsModel get model => _model;

  void setLoading(bool value) {
    _model.isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _model.error = value;
    notifyListeners();
  }

  void setPatients(List<dynamic> patients) {
    _model.patients = patients;
    notifyListeners();
  }

  Future<void> fetchPatients() async {
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
        'http://10.0.2.2:8000/api/table_pasien',
        options: Options(
          headers: {
            'Authorization': 'Token $token', // Gunakan token dari SharedPreferences
          },
        ),
      );

      if (response.statusCode == 200 && response.data is List) {
        setPatients(response.data);
      } else {
        setError('Failed to fetch patients. Please try again.');
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
