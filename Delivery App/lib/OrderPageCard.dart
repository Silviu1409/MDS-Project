import 'package:delivery_app/repository/orderitem_repository.dart';
import 'package:flutter/material.dart';

import 'models/orderitem.dart';

class OrderPageCardWidget extends StatelessWidget {
  const OrderPageCardWidget({Key? key, required this.detalii_produs})
      : super(key: key);
  final Map<String, dynamic> detalii_produs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OrderPageCard(
        detalii_produs: detalii_produs,
      ),
    );
  }
}

class OrderPageCard extends StatefulWidget {
  const OrderPageCard({Key? key, required this.detalii_produs})
      : super(key: key);
  final Map<String, dynamic> detalii_produs;

  @override
  State<OrderPageCard> createState() => OrderPageCardState();
}

class OrderPageCardState extends State<OrderPageCard> {
  OrderItem? orderItem;
  final OrderItemRepository repository_orderitem = OrderItemRepository();

  @override
  void initState() {
    super.initState();
    orderItem = widget.detalii_produs["orderitem"];
  }

  Text customText(BuildContextcontext, String text) {
    double heightval = MediaQuery.of(context).size.height * 0.01;

    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Lato-Black',
          fontSize: 2 * heightval,
          color: Colors.black,
          fontWeight: FontWeight.w700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 15),
            Column(
              children: <Widget>[
                customText(
                  context,
                  "Nume: ${widget.detalii_produs["nume"]}",
                ),
                customText(
                  context,
                  "Preț: ${widget.detalii_produs["pret"]} lei",
                ),
                customText(
                  context,
                  "Cantitate: ${widget.detalii_produs["cantitate"]}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
