class TeacherRegisterStep2Response {
  final String statusCode;
  final String status;
  final String message;
  final String messageAR;
  final String? teacherName;
  final String? schoolName;

  TeacherRegisterStep2Response({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.messageAR,
    this.teacherName,
    this.schoolName,
  });

  factory TeacherRegisterStep2Response.fromJson(Map<String, dynamic> json) {
    return TeacherRegisterStep2Response(
      statusCode: json['statusCode'],
      status: json['status'],
      message: json['message'],
      messageAR: json['messageAR'],
      teacherName: json['TeacherName'],
      schoolName: json['SchoolName'],
    );
  }
}
