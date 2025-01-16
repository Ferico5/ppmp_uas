import 'package:flutter/material.dart';
import '../models/show_detail_queues_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDetailQueuesViewModel extends ChangeNotifier {
  final ShowDetailQueuesModel _model = ShowDetailQueuesModel();

  ShowDetailQueuesModel get model => _model;

  void setLoading(bool value) {
    _model.isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _model.error = value;
    notifyListeners();
  }

  void setQueues(List<dynamic> queues) {
    _model.queues = queues;
    notifyListeners();
  }

  Future<void> fetchQueues() async {
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
        'http://10.0.2.2:8000/api/table_antrian',
        options: Options(
          headers: {
            'Authorization': 'Token $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data is List) {
        setQueues(response.data);
      } else {
        setError('Failed to fetch queues. Please try again.');
      }

      final List<dynamic> queuesWithNames = [];
      for (var queue in response.data) {
        final patientId = queue['pasien'];

        try {
          final patientResponse = await Dio().get(
            'http://10.0.2.2:8000/api/table_pasien/$patientId',
            options: Options(
              headers: {
                'Authorization': 'Token $token',
              },
            ),
          );

          if (patientResponse.statusCode == 200) {
            final patientData = patientResponse.data;
            if (patientData['data'] is Map && patientData['data'].containsKey('nama')) {
              queue['pasienName'] = patientData['data']['nama'];
            } else {
              queue['pasienName'] = 'Unknown Name (Data Missing)';
              setError('Patient data for queue ID: $patientId is missing the "nama" key.');
            }
          } else {
            queue['pasienName'] = 'Unknown Name';
            setError('Failed to fetch patient data for queue ID: $patientId');
          }
        } catch (e) {
          queue['pasienName'] = 'Unknown Name';
          setError('Error fetching patient data: ${e.toString()}');
        }
        queuesWithNames.add(queue);
      }

      setQueues(queuesWithNames);
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