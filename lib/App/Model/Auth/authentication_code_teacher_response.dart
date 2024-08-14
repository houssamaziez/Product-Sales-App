class AuthenticationCodeTeacherResponse {
  final String statusCode;
  final String message;
  final String messageAR;
  final String status;
  final int badge;

  AuthenticationCodeTeacherResponse({
    required this.statusCode,
    required this.message,
    required this.messageAR,
    required this.status,
    required this.badge,
  });

  factory AuthenticationCodeTeacherResponse.fromJson(
      Map<String, dynamic> json) {
    return AuthenticationCodeTeacherResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      messageAR: json['messageAR'],
      status: json['status'],
      badge: json['badge'],
    );
  }
}
