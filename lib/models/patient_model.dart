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
      'nama': name.isNotEmpty ? name : null,  // Cek jika nama tidak kosong, kirim data nama
      'umur': age.isNotEmpty ? age : null,  // Jika umur tidak kosong, kirim nilai umur
      'gender': gender.isNotEmpty ? gender : null,  // Sama untuk gender
      'alamat': address.isNotEmpty ? address : null,  // Sama untuk alamat
      'no_telp': phoneNumber.isNotEmpty ? phoneNumber : null,  // Sama untuk telp
      'email': email.isNotEmpty ? email : null,  // Sama untuk email
    };
  }

  // You might also want to add a fromJson method to convert the map back to an object
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