import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/DeliveryAccountPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'OrderDeliveryCard.dart';
import 'main.dart';
import 'models/shoppingcart.dart';
import 'models/user.dart';
import 'repository/shopping_repository.dart';

class MainDeliveryPageWidget extends StatelessWidget {
  const MainDeliveryPageWidget({Key? key, required this.user})
      : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App main delivery page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainDeliveryPage(
          title: 'Delivery app main delivery page', user: user),
    );
  }
}

class MainDeliveryPage extends StatefulWidget {
  const MainDeliveryPage({Key? key, required this.title, required this.user})
      : super(key: key);
  final User user;
  final String title;

  @override
  State<MainDeliveryPage> createState() => MainDeliveryPageState();
}

class MainDeliveryPageState extends State<MainDeliveryPage> {
  final ShoppingRepository repository_cart = ShoppingRepository();
  static List<String> rejected_orders = [];

  Timer? timer, timer2, timer3;
  bool con = false, old_con = true, is_connected = true;
  static bool modif_order = false;

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
      const Duration(milliseconds: 250),
      (Timer t) => refresh(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    timer2?.cancel();
    timer3?.cancel();
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

  refresh() {
    if (modif_order) {
      setState(() {
        modif_order = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Vrei să ieși din aplicație?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Nu'),
                  ),
                  ElevatedButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text('Da'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                  Text(
                    "Comenzi nepreluate",
                    style: TextStyle(
                        fontFamily: 'Lato-Black',
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: con
                          ? StreamBuilder<QuerySnapshot>(
                              stream: repository_cart.getActiveDeliveries1(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasData) {
                                  if (snapshot.data!.size == 0) {
                                    return const SizedBox();
                                  } else {
                                    return _buildList(
                                        context, snapshot.data?.docs ?? []);
                                  }
                                } else if (snapshot.hasError) {
                                  return const SizedBox();
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
                              : const Center(
                                  child: Text(
                                    "Verifică conexiunea la internet",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                    ),
                                  ),
                                ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    "Comenzi nelivrate",
                    style: TextStyle(
                        fontFamily: 'Lato-Black',
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: con
                          ? StreamBuilder<QuerySnapshot>(
                              stream: repository_cart.getActiveDeliveries2(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasData) {
                                  if (snapshot.data!.size == 0) {
                                    return const SizedBox();
                                  } else {
                                    return _buildList(
                                        context, snapshot.data?.docs ?? []);
                                  }
                                } else if (snapshot.hasError) {
                                  return const SizedBox();
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
                              : const Center(
                                  child: Text(
                                    "Verifică conexiunea la internet",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                    ),
                                  ),
                                ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.fromLTRB(25, 50, 0, 0),
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 2.5,
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        DeliveryAccountPageWidget(user: widget.user),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              splashRadius: 0.1,
              iconSize: 85,
              icon: ClipOval(
                child:
                    Image.asset('images/user icons/${widget.user.image}.jpg'),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 50.0),
      physics: const NeverScrollableScrollPhysics(),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final order = ShoppingCart.fromSnapshot(snapshot);
    for (var orderid in rejected_orders) {
      if (orderid == order.ref?.id) {
        return const SizedBox();
      }
    }
    return Row(
      children: <Widget>[
        OrderDeliveryCard(
          shoppingCart: order,
          user: widget.user,
        ),
      ],
    );
  }
}
