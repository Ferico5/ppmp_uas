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
  final _formKey = GlobalKey<FormState>();
  String? _dropdownPatient;
  String? _dropdownDoctor;

  @override
  void dispose() {
    _queueNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewQueueViewModel()..loadData()..loadNextQueueNo(),
      child: Consumer<NewQueueViewModel>(
        builder: (context, model, child) {
          final String nextQueueNo = model.model.queue_no;

          if (_queueNoController.text.isEmpty) {
            _queueNoController.text = nextQueueNo;
          }

          return Scaffold(
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
                        const SizedBox(height: 16),
                        MyTextFormField(
                          controller: _queueNoController,
                          focusNode: FocusNode(),
                          hintText: "Queue Number...",
                          labelText: "",
                          obscureText: false,
                          validator: null,
                          style: TextStyle(color: Colors.white),
                          readOnly: true,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<Map<String, dynamic>>(
                          decoration: const InputDecoration(
                            hintText: 'Select Patient...',
                            filled: true,
                            fillColor: Colors.white12,
                          ),
                          value: _dropdownPatient != null
                              ? model.patients.firstWhere(
                                  (patient) => patient['nama'] == _dropdownPatient,
                                  orElse: () => {})
                              : null,
                          items: model.patients
                              .map((patient) => DropdownMenuItem<Map<String, dynamic>>(
                                    value: patient,
                                    child: Text(patient['nama']),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _dropdownPatient = value?['nama'];
                              model.setPatient(value?['id'].toString() ?? "");
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<Map<String, dynamic>>(
                          decoration: const InputDecoration(
                            hintText: 'Select Doctor...',
                            filled: true,
                            fillColor: Colors.white12,
                          ),
                          value: _dropdownDoctor != null
                              ? model.doctors.firstWhere(
                                  (doctor) => doctor['nama'] == _dropdownDoctor,
                                  orElse: () => {})
                              : null,
                          items: model.doctors
                              .map((doctor) => DropdownMenuItem<Map<String, dynamic>>(
                                    value: doctor,
                                    child: Text(doctor['nama']),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _dropdownDoctor = value?['nama'];
                              model.setDoctor(value?['id'].toString() ?? "");
                            });
                          },
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}