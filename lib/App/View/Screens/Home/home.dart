import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:product_sales_app/App/Util/Route/Go.dart';

import '../../../Util/Const/List/list_icon_botton.dart';
import '../../../Util/Const/List/list_screens.dart';
import 'ScreensHome/QRscaneView/screenScaneQR.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int visit = 0;
  double height = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: listscreenHome[visit]),
      bottomNavigationBar: BottomBarCreative(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.grey,
        colorSelected: Theme.of(context).primaryColor,
        indexSelected: visit,
        highlightStyle: const HighlightStyle(
          isHexagon: true,
        ),
        onTap: (int index) => setState(() {
          if (index == 2) {
            Go.to(context, QRViewExample());
            visit = 3;
          } else {
            visit = index;
          }
        }),
      ),
    );
  }
}
