import 'package:flutter/material.dart';

class ShoppingCartProductCardWidget extends StatelessWidget {
  const ShoppingCartProductCardWidget({Key? key, required this.detalii_produs})
      : super(key: key);
  final Map<String, dynamic> detalii_produs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ShoppingCartProductCard(
        detalii_produs: detalii_produs,
      ),
    );
  }
}

class ShoppingCartProductCard extends StatefulWidget {
  const ShoppingCartProductCard({Key? key, required this.detalii_produs})
      : super(key: key);
  final Map<String, dynamic> detalii_produs;

  @override
  State<ShoppingCartProductCard> createState() =>
      ShoppingCartProductCardState();
}

class ShoppingCartProductCardState extends State<ShoppingCartProductCard> {
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
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
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
                "Preț: ${widget.detalii_produs["pret"]}",
              ),
              customText(
                context,
                "Cantitate: ${widget.detalii_produs["cantitate"]}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
