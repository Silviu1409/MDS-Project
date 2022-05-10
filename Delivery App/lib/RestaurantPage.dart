import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/HomePage.dart';
import 'package:delivery_app/models/restaurant.dart';
import 'package:delivery_app/repository/produs_repository.dart';
import 'package:flutter/material.dart';

import 'ProductCard.dart';
import 'main.dart';
import 'models/produs.dart';
import 'models/user.dart';

class RestaurantPageWidget extends StatelessWidget {
  const RestaurantPageWidget(
      {Key? key, required this.restaurant, required this.user})
      : super(key: key);
  final Restaurant restaurant;
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: RestaurantPage(
        title: 'Restaurant Page',
        restaurant: restaurant,
        user: user,
      ),
    );
  }
}

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({
    Key? key,
    required this.title,
    required this.restaurant,
    required this.user,
  }) : super(key: key);
  final String title;
  final Restaurant restaurant;
  final User user;

  @override
  State<RestaurantPage> createState() => RestaurantPageState();
}

class RestaurantPageState extends State<RestaurantPage> {
  ProdusRepository repository_produs = ProdusRepository();

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 75),
              Text(
                widget.restaurant.nume,
                style: const TextStyle(
                    fontFamily: 'Lato-Black',
                    fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 50),
              const Text(
                "Produse",
                style: TextStyle(
                    fontFamily: 'Lato-Black',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 50),
              Container(
                child: con
                    ? Center(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: repository_produs
                              .getProductsforRestaurant(widget.restaurant.ref),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasData) {
                              return _buildList(
                                  context, snapshot.data?.docs ?? []);
                            } else if (snapshot.hasError) {
                              return const Text("No data available");
                            } else {
                              return const LinearProgressIndicator();
                            }
                          },
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
                      HomePageWidget(user: widget.user),
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
    final produs = Produs.fromSnapshot(snapshot);

    return Column(
      children: <Widget>[
        ProductCard(
          produs: produs,
          user: widget.user,
          restaurant: widget.restaurant,
        ),
        const SizedBox(height: 25),
      ],
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
}
