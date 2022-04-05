import 'package:flutter/material.dart';

class ShoppingCartProductCardWidget extends StatelessWidget {
  ShoppingCartProductCardWidget({Key? key, required this.detalii_produs})
      : super(key: key);
  Map<String, dynamic> detalii_produs;

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
  ShoppingCartProductCard({Key? key, required this.detalii_produs})
      : super(key: key);
  Map<String, dynamic> detalii_produs;

  @override
  State<ShoppingCartProductCard> createState() =>
      ShoppingCartProductCardState();
}

class ShoppingCartProductCardState extends State<ShoppingCartProductCard> {
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
              Text(
                "Nume: ${widget.detalii_produs["nume"]}",
                style: const TextStyle(
                    fontFamily: 'Lato-Black',
                    fontSize: 17.5,
                    color: Colors.red,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Preț: ${widget.detalii_produs["pret"]}",
                style: const TextStyle(
                    fontFamily: 'Lato-Black',
                    fontSize: 17.5,
                    color: Colors.red,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Cantitate: ${widget.detalii_produs["cantitate"]}",
                style: const TextStyle(
                    fontFamily: 'Lato-Black',
                    fontSize: 17.5,
                    color: Colors.red,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
