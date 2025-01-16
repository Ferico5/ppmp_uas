class DoctorModel {
  bool isLoading;
  String? error;
  String name;
  String phoneNumber;
  String email;

  DoctorModel({
    this.isLoading = false,
    this.error,
    this.name = '',
    this.phoneNumber = '',
    this.email = '',
  });
}