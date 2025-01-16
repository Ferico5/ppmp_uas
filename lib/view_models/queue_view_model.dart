import 'package:flutter/material.dart';
import '../models/queue_model.dart';

class QueueViewModel extends ChangeNotifier {
  final QueueModel _model = QueueModel();

  QueueModel get model => _model;

  // Removed Setters

  Future<void> delete(BuildContext context) async {
    //TODO: Delete Implementation
    await Future.delayed(const Duration(seconds: 2));
  }
}