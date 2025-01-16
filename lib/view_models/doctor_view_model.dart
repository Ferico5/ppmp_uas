import 'package:flutter/material.dart';
import '../models/doctor_model.dart';

class DoctorViewModel extends ChangeNotifier {
  final DoctorModel _model = DoctorModel();

  DoctorModel get model => _model;

  // Removed Setters

  Future<void> delete(BuildContext context) async {
    //TODO: Delete Implementation
    await Future.delayed(const Duration(seconds: 2));
  }
}