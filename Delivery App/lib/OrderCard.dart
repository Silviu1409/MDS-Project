import 'package:delivery_app/models/shoppingcart.dart';
import 'package:flutter/material.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({Key? key, required this.shoppingCart})
      : super(key: key);
  final ShoppingCart shoppingCart;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OrderCard(
        shoppingCart: shoppingCart,
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  const OrderCard({Key? key, required this.shoppingCart}) : super(key: key);
  final ShoppingCart shoppingCart;

  @override
  State<OrderCard> createState() => OrderCardState();
}

class OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Text(
              widget.shoppingCart.ref?.id as String,
              style: const TextStyle(
                  fontFamily: 'Lato-Black',
                  fontSize: 17.5,
                  color: Colors.red,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
