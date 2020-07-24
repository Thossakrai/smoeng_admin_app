import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:smoeng_uniform_admin/Domain/GetOrder.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class VerifyPage extends StatefulWidget {
  final String userId;
  final String orderId;

  const VerifyPage(this.userId, this.orderId);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  CollectionReference users = Firestore.instance.collection('users');
  int snackBarDuration = 1;

  Future<void> setAsPaid() {
    return users
        .document(widget.userId)
        .collection('orders')
        .document(widget.orderId)
        .updateData({'status': 'paid'})
        .then((value) => this._transactionComplete(context))
        .catchError((error) => this._transactionComplete(context));
  }

  void _transactionFail(BuildContext context) {
    Flushbar(
      title: 'Transaction failed',
      message: 'โปรดลองอีกครั้งภายหลัง',
      duration: Duration(seconds: snackBarDuration),
      icon: Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
    )..show(context);
  }

  void _transactionComplete(BuildContext context) {
    //TODO
    Flushbar(
      title: 'Transaction completed',
      message: 'ยืนยันการสั่งซื้อเรียบร้อยแล้ว',
      duration: Duration(seconds: snackBarDuration),
      icon: Icon(
        Icons.check_circle_outline,
        color: Colors.white,
      ),
      backgroundColor: Colors.green,
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VIEW ORDER"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Text("userId = ${widget.userId}"),
              Text("orderId = ${widget.orderId}"),
              GetOrder(widget.userId, widget.orderId),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.WARNING,
            animType: AnimType.SCALE,
            title: 'Confirm Your Action',
            desc: 'This transaction cannot be undone',
            btnCancelOnPress: () {
              //TODO
              Flushbar(
                title: 'Action cancelled',
                message: 'ยกเลิกคำสั่งแล้ว',
                duration: Duration(seconds: snackBarDuration),
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blueGrey,
              )..show(context);
            },
            btnOkOnPress: () {
              print("Sending transaction");
              setAsPaid();
              //TODO
            },
          )..show();
        },
        label: Text("SET AS PAID"),
        tooltip: 'Navigate to Scan Page',
        icon: Icon(Icons.monetization_on),
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
