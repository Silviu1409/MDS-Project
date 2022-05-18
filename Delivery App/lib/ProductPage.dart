import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/RestaurantPage.dart';
import 'package:delivery_app/models/restaurant.dart';
import 'package:delivery_app/repository/produs_repository.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'models/orderitem.dart';
import 'models/produs.dart';
import 'models/user.dart';
import 'repository/orderitem_repository.dart';
import 'repository/shopping_repository.dart';

class ProductPageWidget extends StatelessWidget {
  const ProductPageWidget({
    Key? key,
    required this.produs,
    required this.user,
    required this.restaurant,
  }) : super(key: key);
  final Produs produs;
  final User user;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ProductPage(
        title: 'Product Page',
        produs: produs,
        user: user,
        restaurant: restaurant,
      ),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key? key,
    required this.title,
    required this.produs,
    required this.user,
    required this.restaurant,
  }) : super(key: key);
  final String title;
  final Produs produs;
  final User user;
  final Restaurant restaurant;

  @override
  State<ProductPage> createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  ProdusRepository repository_produs = ProdusRepository();

  bool con = false;
  Timer? timer;
  bool old_con = true;
  bool is_connected = true;
  Timer? timer2;
  int nr_prod = 1;

  bool addedprodtocard = false;
  bool mesajafisat = false;
  Timer? timer3;

  final ShoppingRepository repository_cart = ShoppingRepository();
  final OrderItemRepository repository_orderitem = OrderItemRepository();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => AwaitConnection(),
    );
    timer2 = Timer.periodic(
      const Duration(seconds: 3),
      (Timer t) => isConnected(),
    );
    timer3 = Timer.periodic(
      const Duration(seconds: 3),
      (Timer t) => shoppingcartalert(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    timer2?.cancel();
    timer3?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              Text(
                widget.produs.nume,
                style: TextStyle(
                    fontFamily: 'Lato-Black',
                    fontSize: MediaQuery.of(context).size.height * 0.01 * 3.25,
                    color: Colors.red,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 100),
              (widget.produs.descriere != null && widget.produs.descriere != "")
                  ? Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "\t\t\t\t\t\tDescriere: ${widget.produs.descriere}",
                            style: TextStyle(
                                fontFamily: 'Lato-Black',
                                fontSize: MediaQuery.of(context).size.height *
                                    0.01 *
                                    2.5,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    )
                  : const SizedBox(),
              Text(
                "Pret: ${widget.produs.pret} lei",
                style: TextStyle(
                    fontFamily: 'Lato-Black',
                    fontSize: MediaQuery.of(context).size.height * 0.01 * 2.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      if (nr_prod > 1) {
                        nr_prod -= 1;
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    iconSize: MediaQuery.of(context).size.height * 0.01 * 3.75,
                  ),
                  Text(
                    "$nr_prod",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.01 * 3,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      nr_prod += 1;
                      setState(() {});
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    iconSize: MediaQuery.of(context).size.height * 0.01 * 3.75,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  "Adaugă în coș \t\t\t\t\t ${(nr_prod * widget.produs.pret).toStringAsFixed(2)} lei",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          MediaQuery.of(context).size.height * 0.01 * 2.25),
                ),
                onPressed: () async {
                  String cart_ref = await repository_cart
                      .searchActiveShoppingcarts(widget.user.ref);
                  String prod_ref = widget.produs.ref!.id;
                  String orderitem_ref = await repository_orderitem
                      .checkifprodinOrderItems(cart_ref, prod_ref);
                  if (orderitem_ref != "") {
                    OrderItem orderitem =
                        await repository_orderitem.getOrderItem(orderitem_ref);
                    orderitem.cantitate += nr_prod;
                    repository_orderitem.updateOrderItem(orderitem);
                  } else {
                    DocumentReference? cart_ref = await repository_cart
                        .searchActiveShoppingcarts2(widget.user.ref);
                    OrderItem orderitem = OrderItem(
                      produs: widget.produs.ref as DocumentReference<Object?>,
                      shoppingcart: cart_ref as DocumentReference<Object?>,
                      cantitate: nr_prod,
                    );
                    repository_orderitem.addOrderItem(orderitem);
                  }
                  nr_prod = 1;
                  setState(() {
                    addedprodtocard = true;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: addedprodtocard
                    ? Column(
                        children: <Widget>[
                          Text(
                            "Produs adăugat în coș!",
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height *
                                    0.01 *
                                    1.75),
                          ),
                          const SizedBox(
                            height: 75,
                          ),
                        ],
                      )
                    : const SizedBox(height: 100),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      RestaurantPageWidget(
                    user: widget.user,
                    restaurant: widget.restaurant,
                  ),
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

  AwaitConnection() async {
    bool oldcon = con;
    con = await CheckConnection();
    if (oldcon != con) {
      setState(() {});
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

  shoppingcartalert() {
    if (addedprodtocard && mesajafisat) {
      setState(() {
        addedprodtocard = false;
        mesajafisat = false;
      });
    } else if (addedprodtocard) {
      setState(() {
        mesajafisat = true;
      });
    }
  }
}
