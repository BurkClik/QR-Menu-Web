import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore;

  DatabaseService(this._firebaseFirestore);

  CollectionReference waiterCall =
      FirebaseFirestore.instance.collection('Orders');

  Future<void> callWaiter(String tableNumber, String time) {
    return waiterCall
        .add({
          'orderType': 'Garson Çağırıyor!',
          'tableNumber': tableNumber,
          'time': time,
        })
        .then((value) => print("Waiter has been called"))
        .catchError((error) => print("Failed to call waiter: $error"));
  }

  Future<void> callBillCash(String tableNumber, String time) {
    return waiterCall
        .add({
          'orderType': 'Hesap (Nakit)!',
          'tableNumber': tableNumber,
          'time': time,
        })
        .then((value) => print("Bill has been wanted"))
        .catchError((error) => print("Failed to want bill: $error"));
  }

  Future<void> newOrder(String tableNumber, String time) {
    return waiterCall
        .add({
          'orderType': 'Yeni Sipariş!',
          'tableNumber': tableNumber,
          'time': time,
        })
        .then((value) => print("Successfull"))
        .catchError((error) => print("Failed to order: $error"));
  }
}
