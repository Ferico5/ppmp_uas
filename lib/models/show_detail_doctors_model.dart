class ShowDetailDoctorsModel {
  bool isLoading;
  String? error;
  List<dynamic> doctors;

  ShowDetailDoctorsModel({
    this.isLoading = false,
    this.error,
    this.doctors = const [],
  });
}