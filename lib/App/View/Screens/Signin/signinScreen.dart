import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../Controller/loginController.dart';
import '../../../Util/Go.dart';
import '../../Widgets/TextField.dart';
import '../../Widgets/appbar.dart';
import '../../Widgets/buttonall.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key, required this.role});
  final String role;
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  int indexselect = 0;
  //   'ID': '1062740889',
  // 'Password': "Badr1408",
  TextEditingController namecontroller =
      TextEditingController(text: "1020304050");
  TextEditingController passwordcontroller =
      TextEditingController(text: "123456");
  bool iscontent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const Logo(height: 120),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'تسجيل الدخول',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
              namecontroller: namecontroller,
              title: 'اسم المستخدم',
              suptitle: 'ادخل اسم المستخدم',
              ispassword: false,
            ),
            MyTextfield(
              namecontroller: passwordcontroller,
              title: 'كلمة السر',
              suptitle: 'ادخل كلمة سر',
              ispassword: true,
            ),
            Row(
              children: [
                Spacer(),
                // TextButton(
                //     onPressed: () => Go.to(context, ScreenPasswordRecovery()),
                //     child: Text(
                //       "هل نسيت كلمة السر؟",
                //       style: TextStyle(color: Colors.blue),
                //     )),
              ],
            ),
            GetBuilder<LoginController>(
                init: LoginController(),
                builder: (controller) {
                  return ButtonAll(
                    islogin: controller.isLoading,
                    function: () async {
                      if (namecontroller.text == "" ||
                          passwordcontroller.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text("ادخل اسم المستخدم و كلمة المرور"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        await controller.login(context, namecontroller.text,
                            passwordcontroller.text);
                      }
                    },
                    title: "تسجيل الدخول",
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ذا كنت لا تملك حساب",
                ),
                TextButton(
                    onPressed: () {
                      // Go.to(
                      //     context,
                      //     ScreenCreate(
                      //       role: widget.role,
                      //     ));
                    },
                    child: Text(
                      "انشأ حساب",
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
