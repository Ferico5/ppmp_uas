class QueueModel {
  bool isLoading;
  String? error;
  String queue_no;
  String queue_status;
  String created_on;
  String patient;
  String doctor;

  QueueModel({
    this.isLoading = false,
    this.error,
    this.queue_no = '',
    this.queue_status = '',
    this.created_on = '',
    this.patient = '',
    this.doctor = '',
  });
}