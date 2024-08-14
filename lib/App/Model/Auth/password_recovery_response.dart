class PasswordRecoveryResponse {
  String? statusCode;
  String? message;
  String? messageAR;
  bool? status;
  int? badge;

  PasswordRecoveryResponse({
    this.statusCode,
    this.message,
    this.messageAR,
    this.status,
    this.badge,
  });

  factory PasswordRecoveryResponse.fromJson(Map<String, dynamic> json) {
    return PasswordRecoveryResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      messageAR: json['messageAR'],
      status: json['status'] == 'true',
      badge: json['badge'],
    );
  }
}
