import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const spinkit = SpinKitSpinningLines(
  color: const Color(0xff1073BA),
  size: 50.0,
);
const spinkitwhite = SpinKitSpinningLines(
  color: Colors.white,
  size: 20.0,
);

var spinkwithtitle = Container(
  width: 300,
  height: 300,
  child: Column(
    children: [
      Text("جاري تحميل البيانات ..."),
      SizedBox(
        height: 10,
      ),
      Container(
        child: SpinKitSpinningLines(
          color: const Color(0xff1073BA),
          size: 70.0,
        ),
      ),
    ],
  ),
);
