class ShowDetailPatientsModel {
  bool isLoading;
  String? error;
  List<dynamic> patients;

  ShowDetailPatientsModel({
    this.isLoading = false,
    this.error,
    this.patients = const [],
  });
}