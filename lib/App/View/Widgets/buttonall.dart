import 'package:flutter/material.dart';

import 'flutter_spinkit.dart';

class ButtonAll extends StatelessWidget {
  ButtonAll(
      {super.key,
      required this.function,
      required this.title,
      this.height = 50,
      this.islogin = false});

  final Function function;
  final String title;
  final bool islogin;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          if (islogin) {
          } else {
            function();
          }
        },
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Center(
            child: Row(
              children: [
                Spacer(),
                if (islogin == true) spinkitwhite,
                SizedBox(
                  width: islogin == true ? 10 : 0,
                ),
                Text(
                  islogin == true ? 'جاري التحقق ...' : title,
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
