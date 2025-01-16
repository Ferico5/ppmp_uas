class ShowDetailQueuesModel {
  bool isLoading;
  String? error;
  List<dynamic> queues;

  ShowDetailQueuesModel({
    this.isLoading = false,
    this.error,
    this.queues = const [],
  });
}