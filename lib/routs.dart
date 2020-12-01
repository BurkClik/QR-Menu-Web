import 'package:flutter/widgets.dart';
import 'package:qr_web/screens/home.dart';
import 'package:qr_web/screens/cart.dart';

final Map<String, WidgetBuilder> routes = {
  Home.routeName: (context) => Home(),
  Cart.routeName: (context) => Cart(),
};
