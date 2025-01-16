import 'package:flutter/material.dart';
import '../models/show_detail_queues_model.dart';

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
}