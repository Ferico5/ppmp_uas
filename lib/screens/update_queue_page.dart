import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/update_queue_view_model.dart';
import '../components/my_text_form_field.dart';
import '../components/my_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UpdateQueuePage extends StatefulWidget {
  const UpdateQueuePage({super.key});

  @override
  State<UpdateQueuePage> createState() => _UpdateQueuePageState();
}

class _UpdateQueuePageState extends State<UpdateQueuePage> {
  final _formKey = GlobalKey<FormState>();
  final _queueNoController = TextEditingController();
  final _queueStatusController = TextEditingController();
  final _createdOnController = TextEditingController();
  final _patientController = TextEditingController();
  final _doctorController = TextEditingController();

  final _queueNoFocusNode = FocusNode();
  final _queueStatusFocusNode = FocusNode();
  final _createdOnFocusNode = FocusNode();
  final _patientFocusNode = FocusNode();
  final _doctorFocusNode = FocusNode();

  final List<String> queueStatusOptions = ['Waiting', 'Called', 'Finished', 'Canceled'];
  String? _selectedQueueStatus;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedGender with a default value or from the model
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final model = Provider.of<UpdateQueueViewModel>(context, listen: false);
      _selectedQueueStatus = model.model.queue_status.isEmpty ? 'Waiting' : model.model.queue_status;
    });
  }

  @override
  void dispose() {
    _queueNoController.dispose();
    _queueStatusController.dispose();
    _createdOnController.dispose();
    _patientController.dispose();
    _doctorController.dispose();
    _queueNoFocusNode.dispose();
    _queueStatusFocusNode.dispose();
    _createdOnFocusNode.dispose();
    _patientFocusNode.dispose();
    _doctorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UpdateQueueViewModel(),
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
              "Update Queue",
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
                child: Consumer<UpdateQueueViewModel>(
                  builder: (context, model, child) {
                    // Populate the text fields with existing data
                    _queueNoController.text = model.model.queue_no;
                    _queueStatusController.text = model.model.queue_status;
                    _createdOnController.text = model.model.created_on;
                    _patientController.text = model.model.patient;
                    _doctorController.text = model.model.doctor;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // Center align
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Text(
                            "Edit Data Queue",
                            style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 18,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: const Text(
                            "Queue No. :",
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
                            controller: _queueNoController,
                            focusNode: _queueNoFocusNode,
                            hintText: "Queue No...",
                            labelText: "",
                            // onChanged: model.setQueueNo,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a queue number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: const Text(
                            "Queue Status :",
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
                            value: _selectedQueueStatus,
                            items: queueStatusOptions
                                .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender,
                                    style: const TextStyle(
                                        color: Colors.black))))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                model.setQueueStatus(value);
                                setState(() => _selectedQueueStatus = value);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Select Queue Status",
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
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: const Text(
                            "Created On :",
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
                            controller: _createdOnController,
                            focusNode: _createdOnFocusNode,
                            hintText: "Patient...",
                            labelText: "",
                            onChanged: model.setPatient,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a date";
                              }
                              return null;
                            },
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: const Text(
                            "Patient :",
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
                            controller: _patientController,
                            focusNode: _patientFocusNode,
                            hintText: "Patient...",
                            labelText: "",
                            onChanged: model.setPatient,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a patient";
                              }
                              return null;
                            },
                          ),
                        ),
                        // Email Field
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: const Text(
                            "Doctor :",
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
                            controller: _doctorController,
                            focusNode: _doctorFocusNode,
                            hintText: "Doctor...",
                            labelText: "",
                            onChanged: model.setDoctor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a doctor";
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