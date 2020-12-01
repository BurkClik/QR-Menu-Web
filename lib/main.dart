import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_web/model/order_cart_model.dart';
import 'package:qr_web/routs.dart';
import 'package:qr_web/screens/home.dart';
import 'package:qr_web/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int itemCount = 0;
    final List<String> food = List<String>();
    final List<String> img = List<String>();
    final List<String> price = List<String>();
    final List<int> cList = List<int>();
    return ChangeNotifierProvider(
      create: (_) => CartModel(itemCount, food, price, img, cList),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        initialRoute: Home.routeName,
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
