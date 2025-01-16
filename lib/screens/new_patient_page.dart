import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../view_models/new_patient_view_model.dart';
import '../components/my_text_form_field.dart';
import '../components/my_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> submitPatientData(BuildContext context) async {
    final viewModel = Provider.of<NewPatientViewModel>(context, listen: false);
    viewModel.setLoading(true);
    viewModel.setError(null);

    if (!_formKey.currentState!.validate()) {
      viewModel.setLoading(false);
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        viewModel.setError('You are not authenticated. Please log in again.');
        viewModel.setLoading(false);
        return;
      }

      final data = {
        "nama": viewModel.model.name,
        "umur": int.tryParse(viewModel.model.age) ?? 0,
        "gender": viewModel.model.gender ?? "Male",
        "alamat": viewModel.model.address,
        "no_telp": viewModel.model.phoneNumber,
        "email": viewModel.model.email,
      };

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/table_pasien'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        viewModel.setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil disimpan")),
        );
        Navigator.pushReplacementNamed(context, 'showDetailPatientsPage');
      } else {
        viewModel.setError("Gagal mengirim data: ${response.body}");
      }
    } catch (e) {
      viewModel.setError("Terjadi kesalahan: $e");
    } finally {
      viewModel.setLoading(false);
    }
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Consumer<NewPatientViewModel>(
                builder: (context, model, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Insert New Data Patient",
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyTextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        hintText: "Name...",
                        labelText: "Name",
                        onChanged: model.setName,
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
                        focusNode: _ageFocusNode,
                        hintText: "Age...",
                        labelText: "Age",
                        onChanged: model.setAge,
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
                        hint: const Text("Select Gender"),
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(value: "Female", child: Text("Female")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dropdownValue = value;
                            model.setGender(value);
                          });
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      MyTextFormField(
                        controller: _addressController,
                        focusNode: _addressFocusNode,
                        hintText: "Address...",
                        labelText: "Address",
                        onChanged: model.setAddress,
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
                        focusNode: _phoneNumberFocusNode,
                        hintText: "Phone Number...",
                        labelText: "Phone Number",
                        onChanged: model.setPhoneNumber,
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
                        focusNode: _emailFocusNode,
                        hintText: "Email...",
                        labelText: "Email",
                        onChanged: model.setEmail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      if (model.model.error != null)
                        Text(
                          model.model.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      Center(
                        child: MyButton(
                          text: "Submit",
                          onPressed: () => submitPatientData(context),
                          backgroundColor: const Color(0xFF00A896),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      if (model.model.isLoading)
                        const Center(
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
          ),
        ),
      ),
    );
  }
}
