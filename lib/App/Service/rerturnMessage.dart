import 'package:flutter/material.dart';

import '../View/Widgets/Messages/snack_bar.dart';

getLocalizedMessageTeatcher(context,
    {required String statusCode, required String message}) {
  switch (statusCode) {
    case '105':
      if (message.contains("parameters contains null or empty values")) {
        showMessage(
          context,
          title: "حقول غير مكتملة",
        );
      } else if (message.contains("Teacher Id not Found")) {
        showMessage(
          context,
          title: "بيانات المعلم غير موجودة بالمدرسة",
        );
      }
      break;

    default:
      showMessage(
        context,
        title: message,
      );
  }
}

getLocalizedMessageparent(BuildContext context,
    {required String statusCode, required String message}) {
  switch (statusCode) {
    case '102':
      if (message.contains("parameters contains null or empty values")) {
        showMessage(
          context,
          title: "حقول غير مكتملة",
        );
      } else if (message.contains("Teacher Id not Found")) {
        showMessage(
          context,
          title: "بيانات المعلم غير موجودة بالمدرسة",
        );
      }
      break;
    case '99':
      showMessage(
        context,
        title: "خطأ في الاتصال بالبيانات ... حاول مرة أخرى",
      );
      break;
    case '106':
      showMessage(
        context,
        title: "بيانات المستخدم غير صحيحة",
      );
      break;
    case '101':
      showMessage(
        context,
        title: "كود التسجيل أو كود التفعيل غير صحيح",
      );
      break;
    case '103':
      showMessage(
        context,
        title: "رقم الجوال غير مسجل بالمدرسة",
      );
      break;
    case '104':
      showMessage(
        context,
        title: "المدرسة مضافة من قبل",
      );
      break;
    case '109':
      showMessage(
        context,
        title: "لم يتم الحفظ ... حاول مرة أخرى",
      );
      break;
    case '105':
      showMessage(
        context,
        title: "تم اضافة المدرسة بنجاح",
      );
      break;
    case '101':
      if (message.contains("Code not Valid")) {
        showMessage(
          context,
          title: "كود غير صالح",
        );
      }
      break;
    default:
      showMessage(
        context,
        title: "حدث خطأ",
      );
  }
}
