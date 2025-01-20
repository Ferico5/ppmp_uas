import 'package:flutter/material.dart';
import '../models/new_queue_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewQueueViewModel extends ChangeNotifier {
  final NewQueueModel _model = NewQueueModel();
  List<Map<String, dynamic>> _patients = [];
  List<Map<String, dynamic>> _doctors = [];

  List<Map<String, dynamic>> get patients => _patients;
  List<Map<String, dynamic>> get doctors => _doctors;

  NewQueueModel get model => _model;

  void setQueueNo(String value) {
    _model.queue_no = value;
    notifyListeners();
  }

  void setQueueStatus(String value) {
    _model.queue_status = value;
    notifyListeners();
  }

  void setCreatedOn(String value) {
    _model.created_on = value;
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

  Future<void> loadNextQueueNo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        setError("You are not authenticated. Please log in again.");
        return;
      }

      final response = await http.get(
        Uri.parse('https://api-antrian-rs.onrender.com/api/table_antrian'),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> queueData = json.decode(response.body);
        
        int lastQueueNo = 0;
        for (var item in queueData) {
          int queueNo = int.tryParse(item['no_antrian']) ?? 0;
          if (queueNo > lastQueueNo) {
            lastQueueNo = queueNo;
          }
        }
        _model.queue_no = (lastQueueNo + 1).toString();
      } else {
        setError("Failed to load queue data");
      }
    } catch (e) {
      setError("Error fetching queue data: $e");
    }

    notifyListeners();
  }

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        setError("You are not authenticated. Please log in again.");
        return;
      }

      // Load patients data
      final responsePasien = await http.get(
        Uri.parse('https://api-antrian-rs.onrender.com/api/table_pasien'),
        headers: {'Authorization': 'Token $token'},
      );

      if (responsePasien.statusCode == 200) {
        List<dynamic> pasienData = json.decode(responsePasien.body);
        _patients = pasienData.map((item) {
          return {'id': item['id'], 'nama': item['nama']};
        }).toList();
      } else {
        setError("Failed to load patients");
      }

      // Load doctors data
      final responseDokter = await http.get(
        Uri.parse('https://api-antrian-rs.onrender.com/api/table_dokter'),
        headers: {'Authorization': 'Token $token'},
      );

      if (responseDokter.statusCode == 200) {
        List<dynamic> dokterData = json.decode(responseDokter.body);
        _doctors = dokterData.map((item) {
          return {'id': item['id'], 'nama': item['nama']};
        }).toList();
      } else {
        setError("Failed to load doctors");
      }
    } catch (e) {
      setError("Error fetching data: $e");
    }

    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    setLoading(true);
    setError(null);

    if (_model.queue_no.isEmpty ||
        _model.patient.isEmpty ||
        _model.doctor.isEmpty) {
      setError("Please fill all the fields");
      setLoading(false);
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        setError("You are not authenticated. Please log in again.");
        setLoading(false);
        return;
      }

      final response = await http.post(
        Uri.parse('https://api-antrian-rs.onrender.com/api/table_antrian'),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'no_antrian': _model.queue_no,
          'status_antrian': '0',
          'created_on': DateTime.now().toIso8601String(),
          'pasien': _model.patient,
          'dokter': _model.doctor,
        }),
      );

      if (response.statusCode == 201) {
        setLoading(false);
        Navigator.pushReplacementNamed(context, 'showDetailQueuesPage');
      } else {
        print('error response: ${response.body}');
        setError("Failed to submit queue");
        setLoading(false);
      }
    } catch (e) {
      setError("Error submitting data: $e");
      setLoading(false);
    }
  }
}