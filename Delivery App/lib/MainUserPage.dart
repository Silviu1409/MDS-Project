import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/LoginPage.dart';
import 'package:delivery_app/ShoppingCartPage.dart';
import 'package:delivery_app/models/shoppingcart.dart';
import 'package:flutter/material.dart';
import 'AccountPage.dart';
import 'HomePage.dart';
import 'OrdersPage.dart';
import 'models/user.dart';
import 'repository/orderitem_repository.dart';
import 'repository/shopping_repository.dart';

class MainUserPageWidget extends StatelessWidget {
  const MainUserPageWidget({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App main page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainUserPage(title: 'Delivery app main page', user: user),
    );
  }
}

class MainUserPage extends StatefulWidget {
  const MainUserPage({Key? key, required this.title, required this.user})
      : super(key: key);
  final User user;
  final String title;

  @override
  State<MainUserPage> createState() => MainUserPageState();
}

class MainUserPageState extends State<MainUserPage> {
  int _selectedIndex = 0;
  List<Widget> pages = [];
  int no_items = 0;

  final ShoppingRepository repository_cart = ShoppingRepository();
  final OrderItemRepository repository_orderitem = OrderItemRepository();

  List<Map<String, dynamic>> shoppingcartdet = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    pages = [
      HomePageWidget(user: widget.user),
      ShoppingCartPageWidget(user: widget.user),
      OrdersPageWidget(user: widget.user),
      AccountPageWidget(user: widget.user),
    ];
    getnoproductsshoppingcart();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getnoproductsshoppingcart() async {
    String cart_ref =
        await repository_cart.searchActiveShoppingcarts(widget.user.ref);
    if (cart_ref != "") {
      List<DocumentSnapshot<Object?>> produse =
          await repository_orderitem.getItemsforShoppingCart(cart_ref);
      no_items = produse.length;
      setState(() {});
    } else {
      final newShoppingcart = ShoppingCart(
        user: widget.user.ref,
        finished: false,
        datetime: "",
      );
      repository_cart.addShoppingCarts(newShoppingcart);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: pages[_selectedIndex],
        floatingActionButton: (_selectedIndex == 3)
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const LoginPageWidget(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                backgroundColor: Colors.red,
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              )
            : (_selectedIndex == 1)
                ? FloatingActionButton.extended(
                    onPressed: () {},
                    backgroundColor: Colors.red,
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text("Comandă"),
                  )
                : null,
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Acasă',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              label: 'Coș',
              backgroundColor: Colors.red,
              icon: Stack(
                children: <Widget>[
                  const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 19.0,
                          width: 19.0,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              (no_items < 10) ? "$no_items" : "9+",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30,
              ),
              label: 'Comenzi',
              backgroundColor: Colors.red,
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
                size: 30,
              ),
              label: 'Cont',
              backgroundColor: Colors.red,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
