import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetOrder extends StatelessWidget {
  final String userId;
  final String orderId;

  GetOrder(this.userId, this.orderId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = Firestore.instance.collection('users');
//    Firestore.instance.collection("users").getDocuments().then((QuerySnapshot querySnapshot) => {
//      querySnapshot.documents.forEach((element) {print(element["tel"]);})
//    });
    return FutureBuilder<DocumentSnapshot>(
      future: users.document(userId).collection('orders').document(orderId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("something went wrong");
        } else if (snapshot.hasData) {
          //TODO
          print("Data Available");
          Map<String, dynamic> orderData = snapshot.data.data;
          return Text("DATA: $orderData");
        }
        return Text("Loading");
      },
    );
  }
}
