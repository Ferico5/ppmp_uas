import 'package:flutter/material.dart';
import '../models/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeModel _model = HomeModel();

  HomeModel get model => _model;

  void setLoading(bool value) {
    _model.isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _model.error = value;
    notifyListeners();
  }
}