import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/queue_view_model.dart';
import '../components/info_card_queue.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// Removed import '../flutter_flow/flutter_flow_theme.dart';
// Removed import '../flutter_flow/flutter_flow_util.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key});

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QueueViewModel(),
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
              "Queue's Data",
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
          child: Consumer<QueueViewModel>(
            builder: (context, model, child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InfoCardQueue(
                      queue_no: "001",
                      queue_status: "Waiting",
                      created_on: "18 December 2024",
                      patient: "<Nama pasien 1>",
                      doctor: "<Nama doctor 1>",
                      updateOnPressed: () {
                        Navigator.pushNamed(
                            context, 'updateQueuePage'); // Pass context
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