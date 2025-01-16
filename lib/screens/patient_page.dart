import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/patient_view_model.dart';
import '../components/info_card_patient.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// Removed import '../flutter_flow/flutter_flow_theme.dart';
// Removed import '../flutter_flow/flutter_flow_util.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PatientViewModel(),
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
              "Patient's Data",
              style: TextStyle(
                fontFamily: 'Lexend',
                color: Colors.white,
                fontSize: 26,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Consumer<PatientViewModel>(
            builder: (context, model, child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InfoCardPatient(
                      name: "name",
                      age: "20",
                      gender: "Male",
                      address: "address",
                      phoneNumber: "123",
                      email: "email",
                      updateOnPressed: () {
                        Navigator.pushNamed(
                            context, 'updatePatientPage'); // Pass context
                      },
                      deleteOnPressed: () {
                        model.delete(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}