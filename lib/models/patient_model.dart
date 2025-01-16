class PatientModel {
  bool isLoading;
  String? error;
  String name;
  String age;
  String gender;
  String address;
  String phoneNumber;
  String email;

  PatientModel({
    this.isLoading = false,
    this.error,
    this.name = '',
    this.age = '',
    this.gender = '',
    this.address = '',
    this.phoneNumber = '',
    this.email = '',
  });
}