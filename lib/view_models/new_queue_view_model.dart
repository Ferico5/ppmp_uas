import 'package:flutter/material.dart';
import '../models/new_queue_model.dart';

class NewQueueViewModel extends ChangeNotifier {
  final NewQueueModel _model = NewQueueModel();

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

  Future<void> submit(BuildContext context) async {
    setLoading(true);
    setError(null);
    if (_model.queue_no.isEmpty ||
        _model.queue_status.isEmpty ||
        _model.created_on.isEmpty ||
        _model.patient.isEmpty ||
        _model.doctor.isEmpty) {
      setError("Please fill all the fields");
      setLoading(false);
      return;
    }
    //TODO: Submit data
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
    //Navigate to the next screen
    Navigator.pushReplacementNamed(context,
        'showDetailQueuesPage');
  }
}