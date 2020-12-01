import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_web/theme/size_config.dart';

class Home extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cafe 236',
          style: TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 28.0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/cart");
              },
              icon: Icon(
                Icons.shopping_basket,
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }
}
