import 'package:flutter/material.dart';
import 'package:qr_web/routs.dart';
import 'package:qr_web/screens/home.dart';
import 'package:qr_web/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: Home.routeName,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
