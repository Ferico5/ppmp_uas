import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/queue_view_model.dart';
import '../components/info_card_queue.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key});

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> with TickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ambil ID dari arguments
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final queueId = arguments?['id'];

    if (queueId != null) {
      Future.microtask(() {
        Provider.of<QueueViewModel>(context, listen: false)
            .fetchQueueById(queueId);
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
          "Queue's Data",
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
        child: Consumer<QueueViewModel>(
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
                  InfoCardQueue(
                    queue_no: viewModel.model.queue_no,
                    queue_status: viewModel.model.queue_status,
                    created_on: viewModel.model.created_on,
                    patient: viewModel.model.patient,
                    doctor: viewModel.model.doctor,
                    updateOnPressed: () {
                      Navigator.pushNamed(
                          context, 'updateQueuePage'); // Pass context
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
