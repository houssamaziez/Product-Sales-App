import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product_sales_app/App/Util/Route/Go.dart';

import '../../Widgets/logo.dart';
import '../Home/home.dart';

class ScreenStart extends StatefulWidget {
  const ScreenStart({super.key});

  @override
  State<ScreenStart> createState() => _ScreenStartState();
}

class _ScreenStartState extends State<ScreenStart> {
  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      Go.replace(context, MyHomePage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Logo(
          height: 300,
        ),
      ),
    );
  }
}
