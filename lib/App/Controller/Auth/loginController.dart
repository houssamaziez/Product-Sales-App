// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../../View/Widgets/Messages/snack_bar.dart';

class LoginController extends GetxController {
  bool isLoading = false;
  String errorMessage = '';

  Future<void> login(
      BuildContext context, String email, String password) async {
    isLoading = true;
    errorMessage = '';
    update();

    try {
      final response = await http.post(
        Uri.parse('''
            Endpoint.ApiTeacherNewLoginTeacher'''), // Replace with your API URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'PhoneId': 'F2C7A6ED-F880-450C-9B75-3B3FD9261751-v3',
          'OS': 'ios',
          'ID': email,
          'Password': password,
          'TokenID': '',
          'PhoneType': 'iPhone'
        }),
      );
      if (response.statusCode == 200) {
        // user = TeacherUser.fromJson(json.decode(response.body));

        // if (user!.statusCode == "105") {
        //   storageteatcher.write('ID', email);
        //   storageteatcher.write('Password', password).then((val) {
        //     Go.clearAndTo(context, const HomeTeacher());
        //   });
        // } else {
        //   showMessage(
        //     context,
        //     title: 'اسم المستخدم أو كلمة المرور غير صحيحة',
        //   );
        // }
      } else {
        errorMessage =
            'فشل تسجيل الدخول. يرجى التحقق من بيانات الاعتماد الخاصة بك.';
        showMessage(
          context,
          title: errorMessage,
        );
      }
    } catch (e) {
      errorMessage = 'حدث خطأ. يرجى المحاولة مرة أخرى.';
      showMessage(
        context,
        title: errorMessage,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
