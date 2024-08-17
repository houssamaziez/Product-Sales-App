import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_sales_app/App/Util/Route/Go.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../Controller/Order/order_controller.dart';
import '../../../../../Model/Local/product_data.dart';
import '../CartView/screen_add_cart.dart';
import '../CartView/screen_cart.dart';

class QRViewExample extends StatefulWidget {
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrText;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    controller!.stopCamera();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scane QR to connect'),
        actions: [],
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
          AnimatedBuilder(
            animation: animationController!,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height / 2 -
                    204 +
                    (300 * animationController!.value),
                left: MediaQuery.of(context).size.width / 2 - 146,
                child: Container(
                  width: 292,
                  height: 2,
                  color: Colors.red,
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: qrText != null ? Colors.green : Colors.white,
              child: Text(
                qrText != null ? 'Result: $qrText' : 'Scan a code',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    // Create a StreamSubscription to manage the stream.
    late StreamSubscription subscription;

    // Start listening to the scanned data stream.
    subscription = controller.scannedDataStream.listen((scanData) {
      // Stop listening to the stream.
      subscription.cancel();

      // Navigate to the next screen.
      Go.replace(
        context,
        ScreenAddProductCart(
          strin: scanData.code!,
        ),
      );
    });
  }
}
