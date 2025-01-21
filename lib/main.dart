import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view_models/show_detail_patients_view_model.dart';
import 'view_models/show_detail_doctors_view_model.dart';
import 'view_models/show_detail_queues_view_model.dart';
import 'view_models/patient_view_model.dart';
import 'view_models/doctor_view_model.dart';
import 'view_models/queue_view_model.dart';
import 'view_models/update_patient_view_model.dart';
import 'view_models/update_doctor_view_model.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/new_patient_page.dart';
import 'screens/show_detail_patients_page.dart';
import 'screens/patient_page.dart';
import 'screens/update_patient_page.dart';
import 'screens/new_doctor_page.dart';
import 'screens/show_detail_doctors_page.dart';
import 'screens/doctor_page.dart';
import 'screens/update_doctor_page.dart';
import 'screens/new_queue_page.dart';
import 'screens/show_detail_queues_page.dart';
import 'screens/queue_page.dart';
import 'screens/update_queue_page.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ShowDetailPatientsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShowDetailDoctorsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShowDetailQueuesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PatientViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DoctorViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => QueueViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UpdatePatientViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UpdateDoctorViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Hello World',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          'homePage': (context) => const HomePage(),
          'newPatientPage': (context) => NewPatientPage(token: token ?? ""),
          'showDetailPatientsPage': (context) => const ShowDetailPatientsPage(),
          'patientPage': (context) => const PatientPage(),
          'updatePatientPage': (context) => const UpdatePatientPage(),
          'newDoctorPage': (context) => NewDoctorPage(token: token ?? ""),
          'showDetailDoctorsPage': (context) => const ShowDetailDoctorsPage(),
          'doctorPage': (context) => const DoctorPage(),
          'updateDoctorPage': (context) => const UpdateDoctorPage(),
          'newQueuePage': (context) => const NewQueuePage(),
          'showDetailQueuesPage': (context) => const ShowDetailQueuesPage(),
          'queuePage': (context) => const QueuePage(),
          'updateQueuePage': (context) => const UpdateQueuePage(),
        },
      ),
    );
  }
}
