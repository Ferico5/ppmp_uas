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

  Map<String, dynamic> toJson() {
    return {
      'nama': name.isNotEmpty ? name : null,
      'no_telp': phoneNumber.isNotEmpty ? phoneNumber : null,
      'email': email.isNotEmpty ? email : null,
    };
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['nama'] ?? '',
      phoneNumber: json['no_telp'] ?? '',
      email: json['email'] ?? '',
    );
  }
}