import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/new_queue_view_model.dart';
import '../components/my_text_form_field.dart';
import '../components/my_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewQueuePage extends StatefulWidget {
  const NewQueuePage({super.key});

  @override
  State<NewQueuePage> createState() => _NewQueuePageState();
}

class _NewQueuePageState extends State<NewQueuePage> {
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
  final _formKey = GlobalKey<FormState>();
  String? _dropdownValue;

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
      create: (context) => NewQueueViewModel(),
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
              "Add New Queue",
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
                          "Insert New Data Queue",
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
                    Consumer<NewQueueViewModel>(
                      builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                          child: MyTextFormField(
                            controller: _queueNoController,
                            focusNode: _queueNoFocusNode,
                            hintText: "Queue Number...",
                            labelText: "",
                            onChanged: model.setQueueNo,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the queue number";
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
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Consumer<NewQueueViewModel>(
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
                                  value: 'Waiting',
                                  child: Text('Waiting'),
                                ),
                                DropdownMenuItem(
                                  value: 'Called',
                                  child: Text('Called'),
                                ),
                                DropdownMenuItem(
                                  value: 'Finished',
                                  child: Text('Finished'),
                                ),
                                DropdownMenuItem(
                                  value: 'Canceled',
                                  child: Text('Canceled'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _dropdownValue = value;
                                  model.setQueueStatus(value ?? "Waiting");
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
                    Consumer<NewQueueViewModel>(
                      builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                          child: MyTextFormField(
                            controller: _createdOnController,
                            focusNode: _createdOnFocusNode,
                            hintText: "Created On...",
                            labelText: "",
                            onChanged: model.setCreatedOn,
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
                    Consumer<NewQueueViewModel>(
                      builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                          child: MyTextFormField(
                            controller: _patientController,
                            focusNode: _patientFocusNode,
                            hintText: "Patient...",
                            labelText: "",
                            onChanged: model.setPatient,
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
                    Consumer<NewQueueViewModel>(
                      builder: (context, model, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Menambahkan padding bawah
                          child: MyTextFormField(
                            controller: _doctorController,
                            focusNode: _doctorFocusNode,
                            hintText: "Doctor...",
                            labelText: "",
                            onChanged: model.setDoctor,
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
                      child: Consumer<NewQueueViewModel>(
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