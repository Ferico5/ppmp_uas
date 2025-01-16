class LoginModel {
  String username;
  String password;
  bool passwordVisible;
  bool isLoading;
  String? error;

  LoginModel({
    this.username = '',
    this.password = '',
    this.passwordVisible = false,
    this.isLoading = false,
    this.error,
  });
}