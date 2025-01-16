import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/update_doctor_view_model.dart';
import '../components/my_text_form_field.dart';
import '../components/my_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UpdateDoctorPage extends StatefulWidget {
  const UpdateDoctorPage({super.key});

  @override
  State<UpdateDoctorPage> createState() => _UpdateDoctorPageState();
}

class _UpdateDoctorPageState extends State<UpdateDoctorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UpdateDoctorViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1E2429),
        appBar: AppBar(
          backgroundColor: const Color(0xFF00A896),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Text(
              "Update Doctor",
              style: TextStyle(
                fontFamily: 'Lexend',
                color: Colors.white,
                fontSize: 26,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20), // Padding yang konsisten
              child: Form(
                key: _formKey,
                child: Consumer<UpdateDoctorViewModel>(
                  builder: (context, model, child) {
                    // Populate the text fields with existing data
                    _nameController.text = model.model.name;
                    _phoneController.text = model.model.phoneNumber;
                    _emailController.text = model.model.email;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // Center align
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            "Edit Data Doctor",
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 18,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        // Name Field
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: const Text(
                            "Name :",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 17,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: MyTextFormField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            hintText: "Name...",
                            labelText: "",
                            onChanged: model.setName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a name";
                              }
                              return null;
                            },
                          ),
                        ),
                        // Phone Number Field
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: const Text(
                            "Phone Number :",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 17,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: MyTextFormField(
                            controller: _phoneController,
                            focusNode: _phoneFocusNode,
                            hintText: "Phone Number...",
                            labelText: "",
                            onChanged: model.setPhoneNumber,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a phone number";
                              }
                              return null;
                            },
                          ),
                        ),
                        // Email Field
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: const Text(
                            "Email :",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 17,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: MyTextFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            hintText: "Email...",
                            labelText: "",
                            onChanged: model.setEmail,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter an email";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 40),
                          child: Column(
                            children: [
                              if (model.model.error != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(model.model.error ?? "",
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 14)),
                                ),
                              MyButton(
                                text: "Save",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    model.update(context);
                                  }
                                },
                                backgroundColor: const Color(0xFF00A896),
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
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}