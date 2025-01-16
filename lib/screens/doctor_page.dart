import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/doctor_view_model.dart';
import '../components/info_card_doctor.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> with TickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ambil ID dari arguments
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final doctorId = arguments?['id'];

    if (doctorId != null) {
      Future.microtask(() {
        Provider.of<DoctorViewModel>(context, listen: false)
            .fetchDoctorById(doctorId);
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
          title: const Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Text(
              "Doctor's Data",
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
                      Navigator.pushNamed(context, 'updateDoctorPage');
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
