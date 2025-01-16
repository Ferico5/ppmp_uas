import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';
import '../components/home_card.dart';
import '../components/my_button.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1E2429),
        appBar: AppBar(
          backgroundColor: const Color(0xFF00A896),
          automaticallyImplyLeading: false,
          title: const Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              "Home",
              style: TextStyle(
                fontFamily: 'Lexend',
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 0.0,
              ),
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2,
        ),
        body: Align(
          alignment: AlignmentDirectional(-1, -1),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(24, 40, 24, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Align(
                                alignment: AlignmentDirectional(-1, -1),
                                child: Text(
                                  "Hello, <name>",
                                  style: TextStyle(
                                      fontFamily: 'Lexend',
                                      fontSize: 32,
                                      letterSpacing: 0.0,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 4, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: const [
                                Text(
                                  "High Quality Care Is Our Priority",
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 16,
                                    letterSpacing: 0.0,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Consumer<HomeViewModel>(builder: (context, model, child) {
                      return HomeCard(
                        title: "Patients",
                        buttons: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyButton(
                                text: "Add New Patient",
                                onPressed: () {
                                  Navigator.pushNamed(context, "newPatientPage");
                                },
                                backgroundColor: const Color(0xFF00A896),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB2DFDB),
                                ),
                              ),
                              const SizedBox(width: 16),  // Menambahkan jarak antar tombol
                              MyButton(
                                text: "Show Detail",
                                onPressed: () {
                                  Navigator.pushNamed(context, "showDetailPatientsPage");
                                },
                                backgroundColor: const Color(0xFF00A896),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB2DFDB),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    Consumer<HomeViewModel>(builder: (context, model, child) {
                      return HomeCard(
                        title: "Doctors",
                        buttons: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyButton(
                                text: "Add New Doctor",
                                onPressed: () {
                                  Navigator.pushNamed(context, "newDoctorPage");
                                },
                                backgroundColor: const Color(0xFF00A896),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB2DFDB),
                                ),
                              ),
                              const SizedBox(width: 16),  // Menambahkan jarak antar tombol
                              MyButton(
                                text: "Show Detail",
                                onPressed: () {
                                  Navigator.pushNamed(context, "showDetailDoctorsPage");
                                },
                                backgroundColor: const Color(0xFF00A896),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB2DFDB),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    Consumer<HomeViewModel>(builder: (context, model, child) {
                      return HomeCard(
                        title: "Queues",
                        buttons: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyButton(
                                text: "Add New Queues",
                                onPressed: () {
                                  Navigator.pushNamed(context, "newQueuePage");
                                },
                                backgroundColor: const Color(0xFF00A896),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB2DFDB),
                                ),
                              ),
                              const SizedBox(width: 16),  // Menambahkan jarak antar tombol
                              MyButton(
                                text: "Show Detail",
                                onPressed: () {
                                  Navigator.pushNamed(context, "showDetailQueuesPage");
                                },
                                backgroundColor: const Color(0xFF00A896),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB2DFDB),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}