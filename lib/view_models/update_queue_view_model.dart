import 'package:flutter/material.dart';
import '../models/queue_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateQueueViewModel extends ChangeNotifier {
  final QueueModel _model = QueueModel();
  Map<String, dynamic> initialQueueData = {};

  QueueModel get model => _model;

  void setQueueStatus(String value) {
    _model.queue_status = value;
    notifyListeners();
  }

  void setPatient(String value) {
    _model.patient = value;
    notifyListeners();
  }

  void setDoctor(String value) {
    _model.doctor = value;
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

  void setQueueData(Map<String, dynamic> data) {
    _model.queue_no = data['no_antrian'] ?? '';
    _model.queue_status = data['status_antrian'] ?? '';
    _model.created_on = data['created_on'] ?? '';
    _model.patient = data['pasien'] ?? '';
    _model.doctor = data['dokter'] ?? '';

    initialQueueData = Map.from(data);
    
    notifyListeners();
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
        'https://api-antrian-rs.onrender.com/api/table_antrian/$queueId',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
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

  Future<void> updateQueue(BuildContext context, int queueId) async {
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
        "no_antrian": _model.queue_no.isNotEmpty ? _model.queue_no : initialQueueData["no_antrian"],
        "status_antrian": _model.queue_status.isNotEmpty ? _model.queue_status : initialQueueData["status_antrian"],
        "created_on": _model.created_on.isNotEmpty ? _model.created_on : initialQueueData["created_on"],
        "pasien": _model.patient.isNotEmpty ? _model.patient : initialQueueData["pasien"],
        "dokter": _model.doctor.isNotEmpty ? _model.doctor : initialQueueData["dokter"],
      };

      final response = await Dio().put(
        'https://api-antrian-rs.onrender.com/api/table_antrian/$queueId',
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
            content: Text('Queue updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        setError('Failed to update queue data.');
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