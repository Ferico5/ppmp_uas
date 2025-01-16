import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/show_detail_queues_view_model.dart';
import '../components/detail_card.dart';

class ShowDetailQueuesPage extends StatefulWidget {
  const ShowDetailQueuesPage({super.key});

  @override
  State<ShowDetailQueuesPage> createState() => _ShowDetailQueuesPageState();
}

class _ShowDetailQueuesPageState extends State<ShowDetailQueuesPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShowDetailQueuesViewModel(),
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView(children: [
                  Consumer<ShowDetailQueuesViewModel>(
                      builder: (context, model, child) {
                        return DetailCard(
                          text: "<Nama Pasien, Nomor Antrian>",
                          buttonText: "Detail",
                          onPressed: () {
                            Navigator.pushNamed(context, "queuePage");
                          },
                        );
                      }),
                  Consumer<ShowDetailQueuesViewModel>(
                      builder: (context, model, child) {
                        return DetailCard(
                          text: "<Nama Pasien, Nomor Antrian>",
                          buttonText: "Detail",
                          onPressed: () {
                            print('Button pressed ...');
                          },
                        );
                      }),
                  Consumer<ShowDetailQueuesViewModel>(
                      builder: (context, model, child) {
                        return DetailCard(
                          text: "<Nama Pasien, Nomor Antrian>",
                          buttonText: "Detail",
                          onPressed: () {
                            print('Button pressed ...');
                          },
                        );
                      }),
                  Consumer<ShowDetailQueuesViewModel>(
                      builder: (context, model, child) {
                        return DetailCard(
                          text: "<Nama Pasien, Nomor Antrian>",
                          buttonText: "Detail",
                          onPressed: () {
                            print('Button pressed ...');
                          },
                        );
                      }),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}