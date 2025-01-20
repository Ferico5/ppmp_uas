import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/doctor_view_model.dart';
import '../components/info_card_doctor.dart';
import '../view_models/show_detail_doctors_view_model.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> with TickerProviderStateMixin {
  int? doctorId;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    doctorId = arguments?['id'];

    if (doctorId != null) {
      Future.microtask(() {
        Provider.of<DoctorViewModel>(context, listen: false)
            .fetchDoctorById(doctorId!);
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
            "Doctor's Data",
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
        child: Consumer<DoctorViewModel>(
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
                  InfoCardDoctor(
                    name: viewModel.model.name,
                    phoneNumber: viewModel.model.phoneNumber,
                    email: viewModel.model.email,
                    updateOnPressed: () {
                      Navigator.pushNamed(
                        context, 
                        'updateDoctorPage',
                        arguments: {
                          'doctorId': doctorId,
                          'name': viewModel.model.name,
                          'phoneNumber': viewModel.model.phoneNumber,
                          'email': viewModel.model.email,
                        }
                      );
                    },
                    deleteOnPressed: () async {
                      if (doctorId != null) {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text('Are you sure you want to delete this doctor?'),
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
                            await Provider.of<DoctorViewModel>(context, listen: false)
                                .deleteDoctorById(context, doctorId!);

                            Navigator.pop(context);

                            await Provider.of<ShowDetailDoctorsViewModel>(context, listen: false)
                                .fetchDoctors();

                            Navigator.pushReplacementNamed(context, 'showDetailDoctorsPage');
                          } catch (error) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to delete doctor: $error'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Doctor ID is not available.'),
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
