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

  Map<String, dynamic> toJson() {
    return {
      'no_antrian': queue_no.isNotEmpty ? queue_no : null,
      'status_antrian': queue_status.isNotEmpty ? queue_status : null,
      'created_on': created_on.isNotEmpty ? created_on : null,
      'pasien': patient.isNotEmpty ? patient : null,
      'dokter': doctor.isNotEmpty ? doctor : null,
    };
  }

  factory QueueModel.fromJson(Map<String, dynamic> json) {
    return QueueModel(
      queue_no: json['no_antrian'] ?? '',
      queue_status: json['status_antrian'] ?? 'Waiting',
      created_on: json['created_on'] ?? '',
      patient: json['pasien'] ?? '',
      doctor: json['dokter'] ?? '',
    );
  }
}