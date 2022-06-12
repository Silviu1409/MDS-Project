import 'package:delivery_app/OrderPage.dart';
import 'package:delivery_app/models/shoppingcart.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    Key? key,
    required this.shoppingCart,
    required this.user,
    required this.nr_comanda,
  }) : super(key: key);
  final ShoppingCart shoppingCart;
  final User user;
  final int nr_comanda;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OrderCard(
        shoppingCart: shoppingCart,
        user: user,
        nr_comanda: nr_comanda,
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  const OrderCard({
    Key? key,
    required this.shoppingCart,
    required this.user,
    required this.nr_comanda,
  }) : super(key: key);
  final ShoppingCart shoppingCart;
  final User user;
  final int nr_comanda;

  @override
  State<OrderCard> createState() => OrderCardState();
}

class OrderCardState extends State<OrderCard> {
  Text customText(BuildContext context, String text) {
    double heightval = MediaQuery.of(context).size.height * 0.01;

    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Lato-Black',
          fontSize: 2 * heightval,
          color: Colors.white,
          fontWeight: FontWeight.w700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    OrderPageWidget(
                  shoppingCart: widget.shoppingCart,
                  user: widget.user,
                  nr_comanda: widget.nr_comanda,
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              customText(
                context,
                'Comanda ${widget.nr_comanda}',
              ),
              const SizedBox(height: 30),
              customText(
                context,
                "Plasată pe: ${widget.shoppingCart.datetime}",
              ),
              const SizedBox(
                height: 15,
              ),
              customText(
                context,
                "Total: ${widget.shoppingCart.total.toString()} lei",
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
