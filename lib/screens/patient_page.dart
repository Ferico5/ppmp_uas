import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/patient_view_model.dart';
import '../components/info_card_patient.dart';
import '../view_models/show_detail_patients_view_model.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with TickerProviderStateMixin {
  int? patientId;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    patientId = arguments?['id'];

    if (patientId != null) {
      Future.microtask(() {
        Provider.of<PatientViewModel>(context, listen: false)
            .fetchPatientById(patientId!);
      });
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
                      Navigator.pushNamed(
                        context, 
                        'updatePatientPage'
                      );
                    },
                    deleteOnPressed: () async {
                      if (patientId != null) {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text('Are you sure you want to delete this patient?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          try {
                            await Provider.of<PatientViewModel>(context, listen: false)
                                .deletePatientById(context, patientId!);

                            Navigator.pop(context);

                            await Provider.of<ShowDetailPatientsViewModel>(context, listen: false)
                                .fetchPatients();

                            Navigator.pushReplacementNamed(context, 'showDetailPatientsPage');
                          } catch (error) {
                            Navigator.pop(context); // Tutup dialog jika ada error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to delete patient: $error'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Patient ID is not available.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
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
