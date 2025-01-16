class NewPatientModel {
  String name;
  String age;
  String? gender;
  String address;
  String phoneNumber;
  String email;
  bool isLoading;
  String? error;
  NewPatientModel({
    this.name = '',
    this.age = '',
    this.gender = '',
    this.address = '',
    this.phoneNumber = '',
    this.email = '',
    this.isLoading = false,
    this.error,
  });
}