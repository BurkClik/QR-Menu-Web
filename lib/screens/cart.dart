import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:qr_web/model/order_cart_model.dart';
import 'package:qr_web/services/database_service.dart';
import 'package:qr_web/theme/constants.dart';
import 'package:qr_web/theme/size_config.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  static String routeName = "/cart";

  final DatabaseService databaseService =
      DatabaseService(FirebaseFirestore.instance);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Cafe 236',
          style: TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 48.0),
            child: IconButton(
              onPressed: () {
                print("Demo");
              },
              icon: Icon(
                Icons.delete,
                size: 28,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount: context.watch<CartModel>().food.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(bottom: 24.0, right: 40.0, left: 40.0),
                    child: Column(
                      children: [
                        Container(
                          height: getProportionateScreenHeight(132.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: kSecondaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: getProportionateScreenHeight(132.0),
                                width: getProportionateScreenWidth(100.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        context.read<CartModel>().img[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.read<CartModel>().food[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Kodchasan',
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(
                                        Entypo.price_tag,
                                        size: 16,
                                        color: kThirdColor,
                                      ),
                                      Text(
                                        '${context.read<CartModel>().counterList[index] * double.parse(context.read<CartModel>().fiyat[index])} TL',
                                        style: TextStyle(
                                          color: kThirdColor,
                                          fontFamily: 'Kodchasan',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (context
                                                .read<CartModel>()
                                                .counterList[index] >
                                            0) {
                                          context
                                              .read<CartModel>()
                                              .increaseCounter(index);
                                        }
                                      },
                                      icon: Icon(FontAwesome.plus,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${context.read<CartModel>().counterList[index]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Kodchasan',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        print(context
                                            .read<CartModel>()
                                            .counterList[index]);
                                        if (context
                                                .read<CartModel>()
                                                .counterList[index] >
                                            0) {
                                          context
                                              .read<CartModel>()
                                              .decreaseCounter(index);
                                        } else if (context
                                                .read<CartModel>()
                                                .counterList[index] <=
                                            1) {
                                          context.read<CartModel>().removeFood(
                                              context
                                                  .read<CartModel>()
                                                  .food[index],
                                              context
                                                  .read<CartModel>()
                                                  .fiyat[index],
                                              context
                                                  .read<CartModel>()
                                                  .img[index]);
                                        }
                                      },
                                      icon: Icon(FontAwesome.minus,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Entypo.price_tag,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${context.watch<CartModel>().sumPrice()} TL',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Kodchasan',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        databaseService.newOrder("32", "5");
                      },
                      color: kThirdColor,
                      minWidth: getProportionateScreenWidth(200.0),
                      height: getProportionateScreenHeight(36.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'Siparişi Onayla',
                        style: TextStyle(
                          fontFamily: 'Kodchasan',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    final icons = [
      SpeedDialAction(
        child: Icon(Icons.euro_symbol),
        foregroundColor: Colors.black,
      ),
      SpeedDialAction(
        child: Icon(Icons.call),
        foregroundColor: Colors.black,
      ),
    ];

    return SpeedDialFloatingActionButton(
      actions: icons,
      childOnFold: Icon(
        Icons.person,
        key: UniqueKey(),
      ),
      childOnUnfold: Icon(Icons.add),
      useRotateAnimation: true,
      onAction: _onSpeedDialAction,
    );
  }

  _onSpeedDialAction(int selectedActionIndex) async {
    if (selectedActionIndex == 1) {
      try {
        await databaseService.callWaiter("24", "19");
      } catch (e) {
        print(e.message);
      }
    } else {
      try {
        await databaseService.callBillCash("14", "2");
      } catch (e) {
        print(e.message);
      }
    }
  }
}

class CustomCartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getProportionateScreenHeight(132.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kSecondaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getProportionateScreenHeight(132.0),
                width: getProportionateScreenWidth(100.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/hamburger.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buttermilk Burger',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Kodchasan',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Entypo.price_tag,
                        size: 16,
                        color: kThirdColor,
                      ),
                      Text(
                        '28,50 TL',
                        style: TextStyle(
                          color: kThirdColor,
                          fontFamily: 'Kodchasan',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(FontAwesome.plus, color: Colors.white),
                    Text(
                      "1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Kodchasan',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(FontAwesome.minus, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
