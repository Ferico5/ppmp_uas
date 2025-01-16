import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/login_view_model.dart';
import '../components/my_text_form_field.dart';
import '../components/my_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1E2429),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Image.asset(
                  'assets/images/heart_beat.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 50, 24, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                          child: const Text(
                            "Welcome back",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 32,
                              color: Colors.white,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: const Text(
                            "Login to access your account",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18,
                              color: Colors.white70,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: Consumer<LoginViewModel>(
                          builder: (context, model, child) {
                            return MyTextFormField(
                              controller: _usernameController,
                              focusNode: _usernameFocusNode,
                              labelText: "Username",
                              hintText: "Enter your Username...",
                              onChanged: model.setUsername,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter an username";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Consumer<LoginViewModel>(
                          builder: (context, model, child) {
                            return MyTextFormField(
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              labelText: "Password",
                              hintText: "Enter your password...",
                              obscureText: !model.model.passwordVisible,
                              onChanged: model.setPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a password";
                                }
                                return null;
                              },
                              suffixIcon: InkWell(
                                onTap: () {
                                  model.togglePasswordVisibility();
                                },
                                child: Icon(
                                  model.model.passwordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0x98FFFFFF),
                                  size: 20,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Consumer<LoginViewModel>(
                          builder: (context, model, child) {
                            return Column(
                              children: [
                                if (model.model.error != null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(model.model.error ?? "",
                                        style: const TextStyle(
                                            color: Colors.red, fontSize: 14)),
                                  ),
                                MyButton(
                                  text: "Login",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      model.login(context);
                                    }
                                  },
                                  backgroundColor: Color(0xFF00968A),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                ),
                                if (model.model.isLoading)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: SpinKitCircle(
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}