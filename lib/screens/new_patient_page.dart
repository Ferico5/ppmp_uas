import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../view_models/new_patient_view_model.dart';
import '../components/my_text_form_field.dart';
import '../components/my_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewPatientPage extends StatefulWidget {
  final String token;
  const NewPatientPage({super.key, required this.token});

  @override
  State<NewPatientPage> createState() => _NewPatientPageState();
}

class _NewPatientPageState extends State<NewPatientPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _dropdownValue;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewPatientViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1E2429),
        appBar: AppBar(
          backgroundColor: const Color(0xFF00A896),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Add New Patient",
            style: TextStyle(
              fontFamily: 'Lexend',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: Consumer<NewPatientViewModel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ 
                      Center(
                        child: const Text(
                          "Insert New Data Patient",
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ), 
                      ),
                      const SizedBox(height: 20),
                      MyTextFormField(
                        controller: _nameController,
                        focusNode: FocusNode(),
                        hintText: "Name...",
                        labelText: "Name",
                        onChanged: viewModel.setName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      MyTextFormField(
                        controller: _ageController,
                        focusNode: FocusNode(),
                        hintText: "Age...",
                        labelText: "Age",
                        onChanged: viewModel.setAge,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the age";
                          }
                          return null;
                        },
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _dropdownValue,
                        hint: const Text(
                          "Select Gender",
                          style: TextStyle(color: Colors.white70),
                        ),
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male", style: TextStyle(color: Colors.white),)),
                          DropdownMenuItem(value: "Female", child: Text("Female", style: TextStyle(color: Colors.white),)),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dropdownValue = value;
                            viewModel.setGender(value);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white12,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF00A896),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF00A896),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: const Color(0xFF1E2429),
                      ),
                      const SizedBox(height: 16),
                      MyTextFormField(
                        controller: _addressController,
                        focusNode: FocusNode(),
                        hintText: "Address...",
                        labelText: "Address",
                        onChanged: viewModel.setAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the address";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      MyTextFormField(
                        controller: _phoneNumberController,
                        focusNode: FocusNode(),
                        hintText: "Phone Number...",
                        labelText: "Phone Number",
                        onChanged: viewModel.setPhoneNumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the phone number";
                          }
                          return null;
                        },
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                      const SizedBox(height: 16),
                      MyTextFormField(
                        controller: _emailController,
                        focusNode: FocusNode(),
                        hintText: "Email...",
                        labelText: "Email",
                        onChanged: viewModel.setEmail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      if (viewModel.model.error != null)
                        Text(
                          viewModel.model.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      Center(
                        child: MyButton(
                          text: "Submit",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              viewModel.postData(context, widget.token);
                            }
                          },
                          backgroundColor: const Color(0xFF00A896),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      if (viewModel.model.isLoading)
                        const Center(
                          child: SpinKitCircle(
                            color: Colors.white,
                            size: 50.0,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
