import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/shoppingcart.dart';
import 'package:flutter/material.dart';

import 'MainDeliveryPage.dart';
import 'OrderPageCard.dart';
import 'main.dart';
import 'models/orderitem.dart';
import 'models/user.dart';
import 'repository/orderitem_repository.dart';
import 'repository/shopping_repository.dart';

class OrderPageDeliveryWidget extends StatelessWidget {
  const OrderPageDeliveryWidget({
    Key? key,
    required this.shoppingCart,
    required this.user,
  }) : super(key: key);
  final ShoppingCart shoppingCart;
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OrderPageDelivery(
        shoppingCart: shoppingCart,
        user: user,
      ),
    );
  }
}

class OrderPageDelivery extends StatefulWidget {
  const OrderPageDelivery({
    Key? key,
    required this.shoppingCart,
    required this.user,
  }) : super(key: key);
  final ShoppingCart shoppingCart;
  final User user;

  @override
  State<OrderPageDelivery> createState() => OrderPageDeliveryState();
}

class OrderPageDeliveryState extends State<OrderPageDelivery> {
  final ShoppingRepository repository_cart = ShoppingRepository();
  final OrderItemRepository repository_orderitem = OrderItemRepository();

  List<Map<String, dynamic>> shoppingcartdet = <Map<String, dynamic>>[];

  num total = 0;
  bool con = false, old_con = true, is_connected = true;
  Timer? timer, timer2;

  @override
  void initState() {
    super.initState();
    getproducts();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => AwaitConnection(),
    );
    timer2 = Timer.periodic(
      const Duration(seconds: 3),
      (Timer t) => isConnected(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    timer2?.cancel();
  }

  AwaitConnection() async {
    bool oldcon = con;
    con = await CheckConnection();
    if (con == false) {
      shoppingcartdet = <Map<String, dynamic>>[];
      total = 0;
    } else if (oldcon != con) {
      getproducts();
    }
  }

  isConnected() {
    if (con == old_con && con == false) {
      is_connected = false;
      setState(() {});
    } else {
      is_connected = true;
    }
    old_con = con;
  }

  void getproducts() async {
    List<DocumentSnapshot<Object?>> produse = await repository_orderitem
        .getItemsforShoppingCart(widget.shoppingCart.ref!.id);
    List<OrderItem> orderitems = await repository_orderitem
        .getOrderItemsforShoppingCart(widget.shoppingCart.ref!.id);
    List<Map<String, dynamic>> shoppingcartitems = [];

    for (var i = 0; i < produse.length; i++) {
      var doc1 = produse[i];
      var doc2 = orderitems[i];
      Map<String, dynamic> prod = {
        "nume": doc1.get("name"),
        "pret": doc1.get("price"),
        "cantitate": doc2.cantitate,
        "orderitem": OrderItem(
            cantitate: doc2.cantitate,
            shoppingcart: doc2.shoppingcart,
            produs: doc2.produs),
      };
      prod["orderitem"].ref = doc2.ref;
      shoppingcartitems.add(prod);
    }
    shoppingcartdet = shoppingcartitems;
    total = widget.shoppingCart.total!;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 125),
                    Text(
                      "Plasată: ${widget.shoppingCart.datetime}",
                      style: TextStyle(
                          fontFamily: 'Lato-Black',
                          fontSize:
                              2 * MediaQuery.of(context).size.height * 0.01,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Adresa de livrare: ${widget.shoppingCart.address}",
                      style: TextStyle(
                          fontFamily: 'Lato-Black',
                          fontSize:
                              2 * MediaQuery.of(context).size.height * 0.01,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: (widget.shoppingCart.state == 1)
                          ? Text(
                              "Comandă trimisă",
                              style: TextStyle(
                                  fontFamily: 'Lato-Black',
                                  fontSize: 2 *
                                      MediaQuery.of(context).size.height *
                                      0.01,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )
                          : (widget.shoppingCart.state == 2)
                              ? Text(
                                  "Comandă în curs de livrare",
                                  style: TextStyle(
                                      fontFamily: 'Lato-Black',
                                      fontSize: 2 *
                                          MediaQuery.of(context).size.height *
                                          0.01,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )
                              : Text(
                                  "Comandă livrată",
                                  style: TextStyle(
                                      fontFamily: 'Lato-Black',
                                      fontSize: 2 *
                                          MediaQuery.of(context).size.height *
                                          0.01,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: con
                          ? _buildList(context, shoppingcartdet)
                          : is_connected
                              ? Center(
                                  child: Column(
                                    children: const <Widget>[
                                      CircularProgressIndicator(),
                                      SizedBox(height: 25),
                                      Text(
                                        "Se încarcă ... ",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    children: const <Widget>[
                                      SizedBox(height: 10),
                                      Text(
                                        "Verifică conexiunea la internet",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                    ),
                    Container(
                      child: (total == 0 || !con)
                          ? null
                          : Text(
                              "Total: ${widget.shoppingCart.total} lei",
                              style: const TextStyle(
                                fontFamily: 'Lato-Black',
                                fontSize: 30.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      MainDeliveryPageWidget(user: widget.user),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            backgroundColor: Colors.red,
            icon: const Icon(Icons.arrow_back),
            label: const Text("Înapoi"),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<Map<String, dynamic>> shoppingcart,
  ) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      physics: const NeverScrollableScrollPhysics(),
      children: shoppingcart
          .map((produs) => _buildListItem(context, produs))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Map<String, dynamic> produs) {
    return Column(
      children: <Widget>[
        OrderPageCard(
          detalii_produs: produs,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
