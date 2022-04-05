import 'package:delivery_app/models/produs.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({Key? key, required this.produs, required this.user})
      : super(key: key);
  final Produs produs;
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ProductCard(
        produs: produs,
        user: user,
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.produs, required this.user})
      : super(key: key);
  final Produs produs;
  final User user;

  @override
  State<ProductCard> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
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
            Column(
              children: <Widget>[
                Text(
                  "Nume: ${widget.produs.nume}",
                  style: const TextStyle(
                      fontFamily: 'Lato-Black',
                      fontSize: 17.5,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Descriere: ${widget.produs.descriere}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: 'Lato-Black',
                      fontSize: 17.5,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Pret: ${widget.produs.pret}",
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
      ),
    );
  }
}
