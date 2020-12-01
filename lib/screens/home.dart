import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_web/model/order_cart_model.dart';
import 'package:qr_web/services/database_service.dart';
import 'package:qr_web/theme/constants.dart';
import 'package:qr_web/theme/size_config.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatelessWidget {
  static String routeName = "/home";
  final CollectionReference menu =
      FirebaseFirestore.instance.collection('hamburger');

  final DatabaseService databaseService =
      DatabaseService(FirebaseFirestore.instance);
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
            padding: EdgeInsets.only(right: 48.0),
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
      floatingActionButton: _buildFloatingActionButton(),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40.0, right: 40.0),
              child: Container(
                height: getProportionateScreenHeight(40.0),
                child: TextField(
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontFamily: 'Kodchasan'),
                  cursorColor: Colors.white.withOpacity(0.5),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.5),
                      size: 28,
                    ),
                    labelText: 'Find food or beverage',
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontFamily: 'Kodchasan',
                      fontSize: 16.0,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: getProportionateScreenHeight(152),
              child: ListView(
                padding: EdgeInsets.only(
                  top: 28.0,
                  left: 40.0,
                  right: 40.0,
                ),
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryContainer(
                    image: 'menu_ham',
                    categoryName: 'Hamburger',
                  ),
                  SizedBox(width: 20.0),
                  CategoryContainer(
                    image: 'menu_pizza',
                    categoryName: 'Pizza',
                  ),
                  SizedBox(width: 20.0),
                  CategoryContainer(
                    image: 'menu_pasta',
                    categoryName: 'Makarna',
                  ),
                  SizedBox(width: 20.0),
                  CategoryContainer(
                    image: 'menu_coke',
                    categoryName: 'İçeçekler',
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 28.0, left: 40.0, bottom: 12.0),
              child: Text(
                'Hamburger',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'Kodchasan',
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: menu.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return new ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 24.0, right: 40.0, left: 40.0),
                        child: Container(
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
                                        "${document.data()["image"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: getProportionateScreenWidth(212),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 44.0),
                                      child: Text(
                                        document.data()["name"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Kodchasan',
                                          fontSize: 20,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 44.0, right: 44.0),
                                      child: Text(
                                        document.data()["ingredients"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Kodchasan',
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${document.data()["price"]} TL',
                                          style: TextStyle(
                                            fontFamily: 'Kodchasan',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 28),
                                        FlatButton(
                                          onPressed: () {
                                            if (context
                                                .read<CartModel>()
                                                .food
                                                .contains(
                                                    document.data()['name'])) {
                                              context
                                                      .read<CartModel>()
                                                      .counterList[
                                                  context
                                                      .read<CartModel>()
                                                      .food
                                                      .indexOf(
                                                        document.data()['name'],
                                                      )]++;
                                            } else {
                                              context.read<CartModel>().addFood(
                                                    document.data()['name'],
                                                    document.data()['price'],
                                                    document.data()['image'],
                                                  );
                                            }
                                            print(
                                                context.read<CartModel>().food);
                                            print(context
                                                .read<CartModel>()
                                                .counterList);
                                            print(context
                                                .read<CartModel>()
                                                .fiyat);
                                          },
                                          color: kThirdColor,
                                          minWidth:
                                              getProportionateScreenWidth(80),
                                          height:
                                              getProportionateScreenHeight(32),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            'Sepete Ekle',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Kodchasan',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
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

class CategoryContainer extends StatelessWidget {
  final String image;
  final String categoryName;

  CategoryContainer({this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: getProportionateScreenWidth(92.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: AssetImage("assets/images/$image.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: getProportionateScreenWidth(92.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [Colors.transparent, Colors.black],
              stops: [0.0, 1.0],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Text(
            categoryName,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Kodchasan',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
