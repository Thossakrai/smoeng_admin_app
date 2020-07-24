import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetOrder extends StatefulWidget {
  final String userId;
  final String orderId;


  GetOrder(this.userId, this.orderId);

  @override
  _GetOrderState createState() => _GetOrderState();
}

class _GetOrderState extends State<GetOrder> {
  double textSize = 20;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = Firestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.document(widget.userId).collection('orders').document(widget.orderId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("something went wrong");
        } else if (snapshot.hasData) {
          //TODO
//          print("Data Available");
          Map<String, dynamic> orderData = snapshot.data.data;
          //Access Data inside orderData via ["key"]
          int tempPrice = 0;
          for (int i = 0; i < orderData["orders"].length; i++) {
//            print(orderData["orders"][i]);
            switch (orderData["orders"][i]["product"]) {
              case "เสื้อโปโล" : {
                tempPrice += 300 * orderData["orders"][i]["amount"];
              }
              break;
              case "เสื้อชอป" : {
                tempPrice += 360 * orderData["orders"][i]["amount"];
              }
              break;

              case "เสื้อกาวน์" : {
                tempPrice += 340 * orderData["orders"][i]["amount"];
              }
              break;
            }
          }

//          print("price = $tempPrice");
          return Column(
            children: [
              SizedBox(height: 20,),
              Text("DATA: ${orderData["orders"]}", style: TextStyle(fontSize: textSize)),
              SizedBox(height: 20,),
              Text("TOTAL PRICE = $tempPrice", style: TextStyle(fontSize: textSize),)
            ],
          );
        }
        return Text("Loading");
      },
    );
  }
}
