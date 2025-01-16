import 'package:flutter/material.dart';
import '../models/new_doctor_model.dart';

class NewDoctorViewModel extends ChangeNotifier {
  final NewDoctorModel _model = NewDoctorModel();

  NewDoctorModel get model => _model;

  void setName(String value) {
    _model.name = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _model.phoneNumber = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _model.email = value;
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
    if (_model.name.isEmpty ||
        _model.phoneNumber.isEmpty ||
        _model.email.isEmpty) {
      setError("Please fill all the fields");
      setLoading(false);
      return;
    }
    //TODO: Submit data
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
    //Navigate to the next screen
    Navigator.pushReplacementNamed(context,
        'showDetailDoctorsPage');
  }
}