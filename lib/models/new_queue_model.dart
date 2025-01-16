class NewQueueModel {
  String queue_no;
  String queue_status;
  String created_on;
  String patient;
  String doctor;
  bool isLoading;
  String? error;
  NewQueueModel({
    this.queue_no = '',
    this.queue_status = '',
    this.created_on = '',
    this.patient = '',
    this.doctor = '',
    this.isLoading = false,
    this.error,
  });
}