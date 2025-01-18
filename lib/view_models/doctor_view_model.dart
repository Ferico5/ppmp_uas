import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/doctor_model.dart';
import '../view_models/show_detail_doctors_view_model.dart';
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

  Future<void> deleteDoctorById(BuildContext context, int doctorId) async {
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
        'http://10.0.2.2:8000/api/table_dokter/$doctorId',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        Provider.of<ShowDetailDoctorsViewModel>(context, listen: false).model.doctors.removeWhere((doctor) => doctor['id'] == doctorId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Doctor deleted successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setError('Failed to delete doctor.');
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