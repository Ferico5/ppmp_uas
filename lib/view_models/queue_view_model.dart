import 'package:flutter/material.dart';
import '../models/queue_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class QueueViewModel extends ChangeNotifier {
  final QueueModel _model = QueueModel();

  QueueModel get model => _model;

  void setLoading(bool value) {
    _model.isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _model.error = value;
    notifyListeners();
  }

  void setQueueData(Map<String, dynamic> data) {
    _model.queue_no = data['data']['no_antrian'] ?? '';
    _model.queue_status = _getQueueStatusText(int.tryParse(data['data']['status_antrian'].toString()) ?? 0);
    _model.created_on = _formatDate(data['data']['created_on']);
    _model.patient = '';
    _model.doctor = '';

    final patientId = data['data']['pasien'];
    final doctorId = data['data']['dokter'];

    _fetchPatientName(patientId);
    _fetchDoctorName(doctorId);

    notifyListeners();
  }

   Future<void> _fetchPatientName(int patientId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        _model.patient = 'You are not authenticated. Please log in again.';
        notifyListeners();
        return;
      }

      final response = await Dio().get(
        'http://10.0.2.2:8000/api/tabel_pasien/$patientId',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        _model.patient = response.data['name'] ?? 'Unknown Name';
      }
    } catch (e) {
      _model.patient = 'Error fetching name';
    }
    notifyListeners();
  }

  Future<void> _fetchDoctorName(int doctorId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        _model.doctor = 'You are not authenticated. Please log in again.';
        notifyListeners();
        return;
      }

      final response = await Dio().get(
        'http://10.0.2.2:8000/api/table_dokter/$doctorId',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        _model.doctor = response.data['name'] ?? 'Unknown Name';
      }
    } catch (e) {
      _model.doctor = 'Error fetching name';
    }
    notifyListeners();
  }

  String _getQueueStatusText(int status) {
    switch (status) {
      case 0:
        return 'Sedang menunggu';
      case 1:
        return 'Sudah dipanggil';
      case 2:
        return 'Selesai';
      case 3:
        return 'Batal';
      default:
        return 'Status tidak dikenal';
    }
  }

  String _formatDate(String? date) {
    if (date == null) return '';
    try {
      final DateTime parsedDate = DateTime.parse(date);
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      return formatter.format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  Future<void> fetchQueueById(int queueId) async {
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
        'http://10.0.2.2:8000/api/table_antrian/$queueId',
        options: Options(
          headers: {
            'Authorization': 'Token $token', // Gunakan token dari SharedPreferences
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        setQueueData(response.data);
      } else {
        setError('Failed to fetch queue data.');
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