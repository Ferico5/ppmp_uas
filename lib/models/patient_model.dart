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

  Map<String, dynamic> toJson() {
    return {
      'nama': name.isNotEmpty ? name : null,
      'umur': age.isNotEmpty ? age : null,
      'gender': gender.isNotEmpty ? gender : null,
      'alamat': address.isNotEmpty ? address : null,
      'no_telp': phoneNumber.isNotEmpty ? phoneNumber : null,
      'email': email.isNotEmpty ? email : null,
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      name: json['nama'] ?? '',
      age: json['umur']?.toString() ?? '',
      gender: json['gender'] ?? 'Male',
      address: json['alamat'] ?? '',
      phoneNumber: json['no_telp'] ?? '',
      email: json['email'] ?? '',
    );
  }
}