import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/shoppingcart.dart';
import 'package:flutter/material.dart';
import 'OrderCard.dart';
import 'main.dart';
import 'models/user.dart';
import 'repository/shopping_repository.dart';

class OrdersPageWidget extends StatelessWidget {
  const OrdersPageWidget({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OrdersPage(user: user),
    );
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<OrdersPage> createState() => OrdersPageState();
}

class OrdersPageState extends State<OrdersPage> {
  final ShoppingRepository repository_cart = ShoppingRepository();

  Timer? timer, timer2;
  bool con = false, old_con = true, is_connected = true;
  int nr_comanda = 0;

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
                      "Istoric comenzi",
                      style: TextStyle(
                          fontFamily: 'Lato-Black',
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 75),
                    Container(
                      child: con
                          ? StreamBuilder<QuerySnapshot>(
                              stream: repository_cart
                                  .getOrderHistory(widget.user.ref),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasData) {
                                  if (snapshot.data!.size == 0) {
                                    return const Text(
                                      "Nicio comandă dată.",
                                      style: TextStyle(
                                          fontFamily: 'Lato-Black',
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    );
                                  } else {
                                    return _buildList(
                                        context, snapshot.data?.docs ?? []);
                                  }
                                } else if (snapshot.hasError) {
                                  return const Text("No data available");
                                } else {
                                  return const LinearProgressIndicator();
                                }
                              },
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      physics: const NeverScrollableScrollPhysics(),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final order = ShoppingCart.fromSnapshot(snapshot);
    nr_comanda += 1;

    return Column(
      children: <Widget>[
        OrderCard(
          shoppingCart: order,
          user: widget.user,
          nr_comanda: nr_comanda,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
