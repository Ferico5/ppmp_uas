import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/show_detail_doctors_view_model.dart';
import '../components/detail_card.dart';

class ShowDetailDoctorsPage extends StatefulWidget {
  const ShowDetailDoctorsPage({super.key});

  @override
  State<ShowDetailDoctorsPage> createState() => _ShowDetailDoctorsPageState();
}

class _ShowDetailDoctorsPageState extends State<ShowDetailDoctorsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<ShowDetailDoctorsViewModel>(context, listen: false)
            .fetchDoctors());
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
            onPressed: () => Navigator.pushReplacementNamed(context, 'homePage'),
          ),
          title: const Text(
            "Data Doctors",
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
          child: Consumer<ShowDetailDoctorsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.model.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.model.error != null) {
              return Center(child: Text(viewModel.model.error!));
            }
            if (viewModel.model.doctors.isEmpty) {
              return const Center(child: Text("No doctors available."));
            }
            return ListView.builder(
              itemCount: viewModel.model.doctors.length,
              itemBuilder: (context, index) {
                final doctor = viewModel.model.doctors[index];
                return DetailCard(
                  text: doctor['nama'] ?? 'Unknown Name',
                  buttonText: "Detail",
                  onPressed: () {
                    final doctorId = doctor['id'];
                    Navigator.pushNamed(
                      context,
                      "doctorPage",
                      arguments: {'id': doctorId},
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