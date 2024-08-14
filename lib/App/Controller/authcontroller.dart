// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:smartschool/App/RouteEndPoint/EndPointTeacher/EndPoint.dart';
// import 'package:smartschool/App/View/Widgets/showsnack.dart';
// import 'dart:convert';
// import '../../Model/TeatcherModel/Auth/TeacherRegisterStep1Response.dart';
// import '../../Model/TeatcherModel/Auth/authentication_code_teacher_response.dart';
// import '../../Model/TeatcherModel/Auth/teacher_register_step2_response.dart';

// import '../../Util/Go.dart';
// import '../../View/TeacherView/Screens/Auth/Create/screenconfrm.dart';
// import '../../View/TeacherView/Screens/Auth/Create/screenuserdata.dart';
// import '../../View/TeacherView/Screens/Auth/PasswordRecovery/screenConfermcomd.dart';

// class AuthController extends GetxController {
//   TextEditingController codelogin = TextEditingController(text: "MT52588");
//   TextEditingController codeactivate = TextEditingController(text: 'CD244');
//   TextEditingController howyacontroller =
//       TextEditingController(text: "1020304050");
//   TextEditingController phonecontroller =
//       TextEditingController(text: "966542161243");
//   TextEditingController emailcontroller =
//       TextEditingController(text: "test@test.com");
//   TextEditingController passwordcontroller =
//       TextEditingController(text: "123456");
//   TextEditingController verificationCodeController = TextEditingController();

//   var isLoading = false.obs;
//   var isTimerActive = false.obs;
//   var timerValue = 60.obs;

//   Future<void> registerTeacherStep1(BuildContext context) async {
//     final url = Endpoint.ApiTeacherTeachertRegisterStep1;
//     final headers = {'Content-Type': 'application/json'};
//     final body = json.encode({
//       'regCode': codelogin.text,
//       'activeCode': codeactivate.text,
//       'PhoneId': howyacontroller.text,
//       'PhoneType': 'iPhone',
//       'Key': 'T4rD#dhypFe',
//       'Mobile': phonecontroller.text,
//       'teacherId': howyacontroller.text,
//     });

//     try {
//       isLoading(true);
//       final response =
//           await http.post(Uri.parse(url), headers: headers, body: body);
//       final responseData = json.decode(response.body);

//       if (response.statusCode == "200") {
//         final step1Response =
//             TeacherRegisterStep1Response.fromJson(responseData);
//         if (step1Response.status == 'Success') {
//           Get.to(() => ScreenUserData(), arguments: {
//             'teacherId': howyacontroller.text,
//             'regCode': codelogin.text,
//             'activeCode': codeactivate.text,
//             'PhoneId': howyacontroller.text,
//             'PhoneType': 'iPhone',
//             'Mobile': phonecontroller.text,
//             'Key': 'T4rD#dhypFe',
//             'TeacherName': step1Response.teacherName,
//             'SchoolName': step1Response.schoolName,
//           });
//         } else {
//           showMessage(context, title: step1Response.message);
//         }
//       } else {
//         // Get.snackbar('Error', responseData['message'],
//         //     snackPosition: SnackPosition.BOTTOM);
//         showMessage(context, title: responseData['messageAR']);
//       }
//     } catch (error) {
//       // Get.snackbar('Error', error.toString(),
//       //     snackPosition: SnackPosition.BOTTOM);

//       showMessage(context, title: "حدث خطأ");
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> registerTeacherStep2(BuildContext context) async {
//     final url = Endpoint.ApiTeacherTeachertRegisterStep2;
//     final headers = {'Content-Type': 'application/json'};
//     final body = json.encode({
//       'regCode': codelogin.text,
//       'activeCode': codeactivate.text,
//       'PhoneId': howyacontroller.text,
//       'PhoneType': 'iPhone',
//       'Key': 'T4rD#dhypFe',
//       'Mobile': phonecontroller.text,
//       'teacherId': howyacontroller.text,
//       'Email': emailcontroller.text,
//       'Password': passwordcontroller.text,
//     });

//     try {
//       isLoading(true);
//       final response =
//           await http.post(Uri.parse(url), headers: headers, body: body);
//       final responseData = json.decode(response.body);

//       if (response.statusCode == 200) {
//         final step2Response =
//             TeacherRegisterStep2Response.fromJson(responseData);
//         if (step2Response.status == 'Success') {
//           Get.to(() => ScreeConfirmeCode());
//         } else {
//           showMessage(context, title: step2Response.message.toString());
//         }
//       } else {
//         showMessage(context, title: responseData['message'].toString());
//       }
//     } catch (error) {
//       showMessage(context, title: error.toString());
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> registerTeacherStep3(BuildContext context) async {
//     final url = Endpoint.ApiTeacherauthenticationCodeTeacher;
//     final headers = {'Content-Type': 'application/json'};
//     final body = json.encode({
//       'Code': verificationCodeController.text,
//       'Mobile': phonecontroller.text,
//       'Key': 'T4rD#dhypFe',
//     });

//     try {
//       isLoading(true);
//       final response =
//           await http.post(Uri.parse(url), headers: headers, body: body);
//       final responseData = json.decode(response.body);

//       if (response.statusCode == 200) {
//         final step3Response =
//             AuthenticationCodeTeacherResponse.fromJson(responseData);
//         if (step3Response.status == 'Success') {
//           Go.to(
//               context,
//               ScreenCnFrm(
//                 textdetails: 'تم انشاء الحساب بنجاح',
//               ));
//         } else {
//           showMessage(context, title: step3Response.messageAR.toString());
//         }
//       } else {
//         showMessage(context, title: responseData['messageAR'].toString());
//       }
//     } catch (error) {
//       showMessage(context, title: error.toString());
//     } finally {
//       isLoading(false);
//     }
//   }

//   void startTimer() {
//     isTimerActive(true);
//     timerValue.value = 60;
//     Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       if (timerValue.value > 0) {
//         timerValue.value--;
//       } else {
//         timer.cancel();
//         isTimerActive(false);
//       }
//     });
//   }
// }
