import 'package:flutter/material.dart';

import '../../Util/Go.dart';

AppBar myappbar(BuildContext context, {String title = ""}) {
  return AppBar(
    leading: Container(),
    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    title: Text(title),
    actions: [
      IconButton(
          onPressed: () {
            Go.back(context);
          },
          icon: Image.asset(
            "assets/icons/back.png",
            height: 24,
          ))
    ],
  );
}

AppBar appbarblue(BuildContext context,
    {required String title,
    bool isback = true,
    Widget leading = const SizedBox()}) {
  return AppBar(
    leading: leading,
    actions: [
      if (isback)
        IconButton(
            onPressed: () {
              Go.back(context);
            },
            icon: Image.asset(
              "assets/icons/Arrowlight.png",
              height: 24,
            ))
    ],
    backgroundColor: Theme.of(context).primaryColor,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    ),
  );
}
