import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/update_patient_view_model.dart';
import '../components/my_text_form_field.dart';
import '../components/my_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UpdatePatientPage extends StatefulWidget {
  const UpdatePatientPage({super.key});

  @override
  State<UpdatePatientPage> createState() => _UpdatePatientPageState();
}

class _UpdatePatientPageState extends State<UpdatePatientPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  final List<String> genderOptions = ['Male', 'Female'];
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (arguments != null) {
        final model = Provider.of<UpdatePatientViewModel>(context, listen: false);
        model.setName(arguments['name'] ?? '');
        model.setAge(arguments['age']?.toString() ?? '');
        model.setGender(arguments['gender'] ?? 'Male');
        model.setAddress(arguments['address'] ?? '');
        model.setPhoneNumber(arguments['phoneNumber'] ?? '');
        model.setEmail(arguments['email'] ?? '');

        _nameController.text = model.model.name;
        _ageController.text = model.model.age;
        _addressController.text = model.model.address;
        _phoneController.text = model.model.phoneNumber;
        _emailController.text = model.model.email;
        _selectedGender = model.model.gender;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _ageFocusNode.dispose();
    _addressFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UpdatePatientViewModel(),
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
              "Update Patient",
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
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Consumer<UpdatePatientViewModel>(
                  builder: (context, model, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            "Edit Data Patient",
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
                        // Age Field
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: MyTextFormField(
                            controller: _ageController,
                            focusNode: _ageFocusNode,
                            hintText: "Age...",
                            labelText: "",
                            onChanged: model.setAge,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter an age";
                              }
                              return null;
                            },
                          ),
                        ),
                        // Gender Field
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DropdownButtonFormField<String>(
                            value: _selectedGender,
                            items: genderOptions
                                .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender,
                                    style: const TextStyle(
                                        color: Colors.black)))).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                model.setGender(value);
                                setState(() => _selectedGender = value);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Select gender",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white12,
                              contentPadding:
                              const EdgeInsetsDirectional.fromSTEB(
                                  20, 24, 20, 24),
                            ),
                          ),
                        ),
                        // Address Field
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: MyTextFormField(
                            controller: _addressController,
                            focusNode: _addressFocusNode,
                            hintText: "Address...",
                            labelText: "",
                            onChanged: model.setAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter an address";
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
                                    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
                                    final patientId = arguments?['patientId'] as int?;  // safely retrieve patientId as int
                                    if (patientId != null) {
                                      model.updatePatient(context, patientId);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Patient ID is not available.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                                backgroundColor: const Color(0xFF00A896),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
