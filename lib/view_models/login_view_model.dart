import 'package:flutter/material.dart';
import '../models/login_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginModel _model = LoginModel();

  LoginModel get model => _model;

  void setUsername(String value) {
    _model.username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _model.password = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _model.passwordVisible = !_model.passwordVisible;
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

  Future<void> login(BuildContext context) async {
    setLoading(true);
    setError(null);
    if (_model.username.isEmpty || _model.password.isEmpty) {
      setError("Please fill all the fields");
      setLoading(false);
      return;
    }

    try {
      final response = await Dio().post(
        'http://10.0.2.2:8000/api/login/',
        data: {
          'username': _model.username,
          'password': _model.password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        Navigator.pushReplacementNamed(context, 'homePage');
      } else {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('non_field_errors') && responseData['non_field_errors'] is List) {
            setError((responseData['non_field_errors'] as List).join(' ')); // Gabungkan pesan error
          } else {
            setError('Login failed');
          }
        } else {
          setError('Unexpected error occurred');
        }
      }

    } on DioError catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');
        setError('An error occurred: ${e.response?.data}');
      } else {
        setError('Failed to connect to the server');
      }
    } finally {
      setLoading(false);
    }




    // // Removed email validation

    // //TODO: Login Implementation
    // await Future.delayed(const Duration(seconds: 2));
    // setLoading(false);
    // //Navigate to the next screen
    // Navigator.pushReplacementNamed(context, 'homePage');
  }
}