import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/patient_view_model.dart';
import '../components/info_card_patient.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with TickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ambil ID dari arguments
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final patientId = arguments?['id'];

    print("Arguments received in PatientPage: $arguments");

    if (patientId != null) {
      print('Fetching data for patient ID: $patientId');
      // Panggil fungsi fetch data pasien berdasarkan ID
      Future.microtask(() {
        Provider.of<PatientViewModel>(context, listen: false)
            .fetchPatientById(patientId);
      });
    } else {
      print('No patient ID provided in arguments.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          "Patient's Data",
          style: TextStyle(
            fontFamily: 'Lexend',
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Consumer<PatientViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.model.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.model.error != null) {
              return Center(
                child: Text(
                  viewModel.model.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  InfoCardPatient(
                    name: viewModel.model.name,
                    age: viewModel.model.age,
                    gender: viewModel.model.gender,
                    address: viewModel.model.address,
                    phoneNumber: viewModel.model.phoneNumber,
                    email: viewModel.model.email,
                    updateOnPressed: () {
                      Navigator.pushNamed(context, 'updatePatientPage');
                    },
                    deleteOnPressed: () {
                      viewModel.delete(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
