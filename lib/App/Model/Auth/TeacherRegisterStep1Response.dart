class TeacherRegisterStep1Response {
  final String statusCode;
  final String status;
  final String message;
  final String messageAR;
  final String teacherName;
  final String schoolName;

  TeacherRegisterStep1Response({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.messageAR,
    required this.teacherName,
    required this.schoolName,
  });

  factory TeacherRegisterStep1Response.fromJson(Map<String, dynamic> json) {
    return TeacherRegisterStep1Response(
      statusCode: json['statusCode'],
      status: json['status'],
      message: json['message'],
      messageAR: json['messageAR'],
      teacherName: json['TeacherName'],
      schoolName: json['SchoolName'],
    );
  }
}
