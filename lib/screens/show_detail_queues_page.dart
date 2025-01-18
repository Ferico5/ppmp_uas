import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/show_detail_queues_view_model.dart';
import '../components/detail_card_queue.dart';

class ShowDetailQueuesPage extends StatefulWidget {
  const ShowDetailQueuesPage({super.key});

  @override
  State<ShowDetailQueuesPage> createState() => _ShowDetailQueuesPageState();
}

class _ShowDetailQueuesPageState extends State<ShowDetailQueuesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<ShowDetailQueuesViewModel>(context, listen: false)
            .fetchQueues());
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
            "Data Queues",
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
          child: Consumer<ShowDetailQueuesViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.model.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.model.error != null) {
              return Center(child: Text(viewModel.model.error!));
            }
            if (viewModel.model.queues.isEmpty) {
              return const Center(child: Text("No queues available."));
            }
            return ListView.builder(
              itemCount: viewModel.model.queues.length,
              itemBuilder: (context, index) {
                final queue = viewModel.model.queues[index];
                return DetailCardQueue(
                  patientName: queue['pasienName'] ?? 'Unknown Name',
                  queueNumber: queue['no_antrian'].toString(),
                  text: queue['pasienName'] ?? 'Unknown Name',
                  buttonText: "Detail",
                  onPressed: () {
                    final queueId = queue['id'];
                    Navigator.pushNamed(
                      context,
                      "queuePage",
                      arguments: {'id': queueId},
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