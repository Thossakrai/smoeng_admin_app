import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:smoeng_uniform_admin/verify.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  int snackBarDuration = 3;
  String qrCodeResult = "Not Scanned Yet";
  String userId;
  String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SCAN & PAY"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Result",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                qrCodeResult,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  var codeScanner =
                      await BarcodeScanner.scan(); //barcode scanner
                  print("raw content = " + codeScanner.rawContent);
                  Map<String, dynamic> user =
                      jsonDecode(codeScanner.rawContent);
                  print(user["orderId"]);
//                  GetOrder(user["userId"], user["orderId"]);
                  setState(() {
                    userId = user["userId"];
                    orderId = user["orderId"];
                    qrCodeResult = codeScanner.rawContent;
                  });
                },
                child: Text(
                  "OPEN QR CODE SCANNER",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.deepOrange, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  if (orderId != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            VerifyPage(this.userId, this.orderId)));
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'METHOD NOT ALLOW',
                      desc: 'You haven\'t scan any qr code yet.',
                      btnCancelOnPress: () {},
                    )..show();
                  }
                },
                child: Text(
                  "VIEW ORDER",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  setState(() {
                    qrCodeResult = "Not Scanned Yet";
                    orderId = null;
                    userId = null;
                  });
                  Flushbar(
                    title: 'Data has been reset',
                    message: 'รีเซ็ตข้อมูลและพร้อมแสกนแล้ว',
                    duration: Duration(seconds: snackBarDuration),
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blueGrey,
                  )..show(context);
                },
                child: Text(
                  "RESET",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blueGrey, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              )
            ],
          ),
        ));
  }
}
