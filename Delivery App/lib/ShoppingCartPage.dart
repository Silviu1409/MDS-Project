import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/ShoppingCartProductCard.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'models/user.dart';
import 'repository/orderitem_repository.dart';
import 'repository/shopping_repository.dart';

class ShoppingCartPageWidget extends StatelessWidget {
  const ShoppingCartPageWidget({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ShoppingCartPage(user: user),
    );
  }
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ShoppingCartPage> createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  final ShoppingRepository repository_cart = ShoppingRepository();
  final OrderItemRepository repository_orderitem = OrderItemRepository();

  List<Map<String, dynamic>> shoppingcartdet = <Map<String, dynamic>>[];

  double total = 0;
  bool con = false;
  Timer? timer;
  bool old_con = true;
  bool is_connected = true;
  Timer? timer2;

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
  }

  @override
  void dispose() {
    timer?.cancel();
    timer2?.cancel();
    super.dispose();
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
    String cart_ref =
        await repository_cart.searchActiveShoppingcarts(widget.user.ref);
    if (cart_ref != "") {
      List<DocumentSnapshot<Object?>> produse =
          await repository_orderitem.getItemsforShoppingCart(cart_ref);
      List<int> cant = await repository_orderitem.getCant(cart_ref);
      double pret_total = 0;
      List<Map<String, dynamic>> shoppingcartitems = [];
      int i = 0;
      for (DocumentSnapshot doc in produse) {
        double pret = doc.get("price");
        int c = cant[i];
        Map<String, dynamic> prod = {
          "nume": "",
          "pret": 0.0,
          "cantitate": 0,
        };
        prod["nume"] = doc.get("name");
        prod["pret"] = pret;
        prod["cantitate"] = c;
        pret_total += pret * c;
        shoppingcartitems.add(prod);
        i += 1;
      }
      print("Shopping cart:\n$shoppingcartitems");
      print("Pret total: $pret_total");
      shoppingcartdet = shoppingcartitems;
      total = pret_total;
    } else {
      print("Niciun shopping cart activ.");
    }
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
                    const SizedBox(height: 100),
                    const Text(
                      "Coș",
                      style: TextStyle(
                          fontFamily: 'Lato-Black',
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      child: con
                          ? (total != 0)
                              ? _buildList(context, shoppingcartdet)
                              : const Text(
                                  "Coșul este gol.",
                                  style: TextStyle(
                                    fontFamily: 'Lato-Black',
                                    fontSize: 20.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
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
                      child: (total == 0)
                          ? null
                          : Text(
                              "Total: $total",
                              style: const TextStyle(
                                fontFamily: 'Lato-Black',
                                fontSize: 30.0,
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
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
        ShoppingCartProductCard(
          detalii_produs: produs,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
