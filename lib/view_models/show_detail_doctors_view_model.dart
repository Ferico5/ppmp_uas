import 'package:flutter/material.dart';
import '../models/show_detail_doctors_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDetailDoctorsViewModel extends ChangeNotifier {
  final ShowDetailDoctorsModel _model = ShowDetailDoctorsModel();

  ShowDetailDoctorsModel get model => _model;

  void setLoading(bool value) {
    _model.isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _model.error = value;
    notifyListeners();
  }

  void setDoctors(List<dynamic> doctors) {
    _model.doctors = doctors;
    notifyListeners();
  }

  Future<void> fetchDoctors() async {
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
        'http://10.0.2.2:8000/api/table_dokter',
        options: Options(
          headers: {
            'Authorization': 'Token $token', // Gunakan token dari SharedPreferences
          },
        ),
      );

      if (response.statusCode == 200 && response.data is List) {
        setDoctors(response.data);
      } else {
        setError('Failed to fetch doctors. Please try again.');
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
