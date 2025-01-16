import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/show_detail_patients_view_model.dart';
import '../components/detail_card.dart';

class ShowDetailPatientsPage extends StatefulWidget {
  const ShowDetailPatientsPage({super.key});

  @override
  State<ShowDetailPatientsPage> createState() => _ShowDetailPatientsPageState();
}

class _ShowDetailPatientsPageState extends State<ShowDetailPatientsPage> {
  @override
  void initState() {
    super.initState();
    
    Future.microtask(() =>
        Provider.of<ShowDetailPatientsViewModel>(context, listen: false)
            .fetchPatients());
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
          "Data Patients",
          style: TextStyle(
            fontFamily: 'Lexend',
            color: Colors.white,
            fontSize: 22,
            letterSpacing: 0.0,
          ),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Consumer<ShowDetailPatientsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.model.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.model.error != null) {
              return Center(child: Text(viewModel.model.error!));
            }
            if (viewModel.model.patients.isEmpty) {
              return const Center(child: Text("No patients available."));
            }
            return ListView.builder(
              itemCount: viewModel.model.patients.length,
              itemBuilder: (context, index) {
                final patient = viewModel.model.patients[index];
                return DetailCard(
                  text: patient['nama'] ?? 'Unknown Name',
                  buttonText: "Detail",
                  onPressed: () {
                    final patientId = patient['id'];
                    Navigator.pushNamed(
                      context,
                      "patientPage",
                      arguments: {'id': patientId},
                    );
                  },
                  animationIndex: index + 1,
                );
              },
            );
          },
        ),
      ),
    );
  }
}