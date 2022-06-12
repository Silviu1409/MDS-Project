import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/MainUserPage.dart';
import 'package:delivery_app/ShoppingCartProductCard.dart';
import 'package:delivery_app/models/orderitem.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'models/shoppingcart.dart';
import 'models/user.dart';
import 'repository/orderitem_repository.dart';
import 'repository/shopping_repository.dart';
import 'package:intl/intl.dart';

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
  late ShoppingCart shoppingCart;

  static num total = 0;
  bool con = false, old_con = true, is_connected = true, isFormValid = true;
  Timer? timer, timer2;
  static bool loading = false;
  String address = "";

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
    total = 0;
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

  static void calculate_total(List<num> preturi, List<int> cant) {
    for (var i = 0; i < preturi.length; i++) {
      total += preturi[i] * cant[i];
    }
  }

  void getproducts() async {
    String cart_ref =
        await repository_cart.searchActiveShoppingcarts(widget.user.ref);
    shoppingCart = await repository_cart.getShoppingCart(cart_ref);
    if (cart_ref != "") {
      List<DocumentSnapshot<Object?>> produse =
          await repository_orderitem.getItemsforShoppingCart(cart_ref);
      List<OrderItem> orderitems =
          await repository_orderitem.getOrderItemsforShoppingCart(cart_ref);
      List<int> cant = await repository_orderitem.getCant(cart_ref);
      List<Map<String, dynamic>> shoppingcartitems = [];
      List<num> preturi = [];
      total = 0;
      int j = 0;
      for (var i = 0; i < produse.length; i++) {
        var doc1 = produse[i];
        var doc2 = orderitems[i];
        num pret = doc1.get("price");
        preturi.add(pret);
        Map<String, dynamic> prod = {
          "nume": doc1.get("name"),
          "pret": pret,
          "cantitate": cant[j],
          "orderitem": OrderItem(
              cantitate: doc2.cantitate,
              shoppingcart: doc2.shoppingcart,
              produs: doc2.produs),
        };
        prod["orderitem"].ref = doc2.ref;
        shoppingcartitems.add(prod);
        j += 1;
      }
      calculate_total(preturi, cant);
      shoppingcartdet = shoppingcartitems;
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                                    color: Colors.black,
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
                      child: (total == 0 || !con || loading)
                          ? null
                          : Text(
                              "Total: ${total.toStringAsFixed(2)} lei",
                              style: const TextStyle(
                                fontFamily: 'Lato-Black',
                                fontSize: 30.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: (total != 0)
                          ? TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autocorrect: false,
                              onChanged: (value) {
                                setState(() {
                                  address = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  isFormValid = false;
                                  return "* Required";
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                hintText: 'Adresă',
                                prefixIcon: Icon(Icons.home),
                              ),
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: (total == 0)
            ? null
            : (address == "")
                ? FloatingActionButton.extended(
                    onPressed: () {},
                    backgroundColor: Colors.grey,
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text("Comandă"),
                  )
                : FloatingActionButton.extended(
                    onPressed: () {
                      shoppingCart.address = address;
                      shoppingCart.finished = true;
                      shoppingCart.total = num.parse(total.toStringAsFixed(2));
                      shoppingCart.state = 1;
                      DateTime now = DateTime.now();
                      DateTime data = DateTime(now.year, now.month, now.day,
                          now.hour, now.minute, now.second);
                      shoppingCart.datetime =
                          DateFormat('dd/MM/yyyy, HH:mm').format(data);
                      repository_cart.updateCart(shoppingCart);
                      final newShoppingcart = ShoppingCart(
                        user: widget.user.ref,
                        finished: false,
                        datetime: "",
                      );
                      repository_cart.addShoppingCarts(newShoppingcart);
                      MainUserPageState.no_items = 0;
                      getproducts();
                    },
                    backgroundColor: Colors.red,
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text("Comandă"),
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
          state: this,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
