import 'package:flutter/material.dart';
import '../models/new_patient_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewPatientViewModel extends ChangeNotifier {
  final NewPatientModel _model = NewPatientModel();

  NewPatientModel get model => _model;

  void setName(String value) {
    _model.name = value;
    notifyListeners();
  }

  void setAge(String value) {
    _model.age = value;
    notifyListeners();
  }

  void setGender(String? value) {
    _model.gender = value;
    notifyListeners();
  }

  void setAddress(String value) {
    _model.address = value;
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

  Future<void> postData(BuildContext context, String token) async {
    setLoading(true);
    setError(null);

    if (_model.name.isEmpty ||
        _model.age.isEmpty ||
        _model.address.isEmpty ||
        _model.phoneNumber.isEmpty ||
        _model.email.isEmpty) {
      setError("Please fill all the fields");
      setLoading(false);
      return;
    }

    final url = Uri.parse('http://10.0.2.2:8000/api/table_pasien');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };

    final body = jsonEncode({
      'nama': _model.name,
      'umur': int.tryParse(_model.age) ?? 0,
      'gender': _model.gender ?? 'Male',
      'alamat': _model.address,
      'no_telp': _model.phoneNumber,
      'email': _model.email,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
          backgroundColor: Colors.green,
        ));
        Navigator.pushReplacementNamed(context, 'showDetailPatientsPage');
      } else {
        final errorData = jsonDecode(response.body);
        setError(errorData['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      setError("Failed to connect to the server");
    } finally {
      setLoading(false);
    }
  }
}