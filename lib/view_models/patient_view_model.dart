import 'package:flutter/material.dart';
import '../models/patient_model.dart';

class PatientViewModel extends ChangeNotifier {
  final PatientModel _model = PatientModel();

  PatientModel get model => _model;

  // Removed Setters

  Future<void> delete(BuildContext context) async {
    //TODO: Delete Implementation
    await Future.delayed(const Duration(seconds: 2));
  }
}