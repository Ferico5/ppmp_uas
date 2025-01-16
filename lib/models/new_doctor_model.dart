class NewDoctorModel {
  String name;
  String phoneNumber;
  String email;
  bool isLoading;
  String? error;
  NewDoctorModel({
    this.name = '',
    this.phoneNumber = '',
    this.email = '',
    this.isLoading = false,
    this.error,
  });
}