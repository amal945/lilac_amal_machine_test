class SendOtpResponseModel {
  final int? data;
  final bool status;
  final String message;

  SendOtpResponseModel({
    this.data,
    required this.status,
    required this.message,
  });

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return SendOtpResponseModel(
      data: json['data'],
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
