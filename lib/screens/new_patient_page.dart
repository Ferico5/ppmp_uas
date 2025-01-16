import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/new_patient_view_model.dart';
import '../components/my_text_form_field.dart';
import '../components/my_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewPatientPage extends StatefulWidget {
  const NewPatientPage({super.key});

  @override
  State<NewPatientPage> createState() => _NewPatientPageState();
}

class _NewPatientPageState extends State<NewPatientPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String? _dropdownValue;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _ageFocusNode.dispose();
    _addressFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewPatientViewModel(),
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
              "Add New Patient",
              style: TextStyle(
                fontFamily: 'Lexend',
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 0.0,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: Align(
          alignment: AlignmentDirectional(-1, -1),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, -1),
                      child: const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          "Insert New Data Patient",
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 18,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                    Consumer<NewPatientViewModel>(
                      builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                          child: MyTextFormField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            hintText: "Name...",
                            labelText: "",
                            onChanged: model.setName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the name";
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: const Text(
                        "Age :",
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 17,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Consumer<NewPatientViewModel>(
                      builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                          child: MyTextFormField(
                            controller: _ageController,
                            focusNode: _ageFocusNode,
                            hintText: "Age...",
                            labelText: "",
                            onChanged: model.setAge,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the age";
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: const Text(
                        "Gender :",
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 17,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Consumer<NewPatientViewModel>(
                        builder: (context, model, child) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                hintText: 'Select...',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 15,
                                  letterSpacing: 0.0,
                                  color: Colors.white,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF00A896),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white12,
                                contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                              ),
                              value: _dropdownValue,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Male',
                                  child: Text('Male'),
                                ),
                                DropdownMenuItem(
                                  value: 'Female',
                                  child: Text('Female'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _dropdownValue = value;
                                  model.setGender(value);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: const Text(
                        "Address :",
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 17,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Consumer<NewPatientViewModel>(
                      builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                          child: MyTextFormField(
                            controller: _addressController,
                            focusNode: _addressFocusNode,
                            hintText: "Address...",
                            labelText: "",
                            onChanged: model.setAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the address";
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
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
                    Consumer<NewPatientViewModel>(
                      builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                          child: MyTextFormField(
                            controller: _phoneNumberController,
                            focusNode: _phoneNumberFocusNode,
                            hintText: "Phone Number...",
                            labelText: "",
                            onChanged: model.setPhoneNumber,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the phone number";
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
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
                    Consumer<NewPatientViewModel>(
                      builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                          child: MyTextFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            hintText: "Email...",
                            labelText: "",
                            onChanged: model.setEmail,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the email";
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 40),
                      child: Consumer<NewPatientViewModel>(
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
                                text: "Submit",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    model.submit(context);
                                  }
                                },
                                backgroundColor: const Color(0xFF00A896),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0),
                                borderRadius: BorderRadius.circular(8),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}