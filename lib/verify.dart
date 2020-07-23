import 'package:flutter/material.dart';
import 'package:smoeng_uniform_admin/Domain/GetOrder.dart';


class VerifyPage extends StatefulWidget {
  final String userId;
  final String orderId;

  const VerifyPage(this.userId, this.orderId);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VIEW ORDER"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text("userId = ${widget.userId}"),
              Text("orderId = ${widget.orderId}"),
              GetOrder(widget.userId, widget.orderId),
              FlatButton(child: Text("SET AS PAID"), onPressed: null,)
            ],
          ),
        ),
      ),
    );
  }
}

