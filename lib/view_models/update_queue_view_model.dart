import 'package:flutter/material.dart';
import '../models/queue_model.dart';

class UpdateQueueViewModel extends ChangeNotifier {
  final QueueModel _model = QueueModel();

  QueueModel get model => _model;

  // void setName(String value) {
  //   _model.name = value;
  //   notifyListeners();
  // }

  // void setAge(String value) {
  //   _model.age = value;
  //   notifyListeners();
  // }

  // void setGender(String value) {
  //   _model.gender = value;
  //   notifyListeners();
  // }

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

  Future<void> update(BuildContext context) async {
    setLoading(true);
    setError(null);

    if (_model.queue_status.isEmpty ||
        _model.patient.isEmpty ||
        _model.doctor.isEmpty) {
      setError("Please fill all the fields");
      setLoading(false);
      return;
    }

    // Simulate an async update operation (e.g., API call)
    await Future.delayed(const Duration(seconds: 2));

    setLoading(false);
    Navigator.pop(context);
  }
}