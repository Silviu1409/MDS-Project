import 'package:delivery_app/ProductPage.dart';
import 'package:delivery_app/models/produs.dart';
import 'package:flutter/material.dart';
import 'models/restaurant.dart';
import 'models/user.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget(
      {Key? key,
      required this.produs,
      required this.user,
      required this.restaurant})
      : super(key: key);
  final Produs produs;
  final User user;
  final Restaurant restaurant;

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
        restaurant: restaurant,
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard(
      {Key? key,
      required this.produs,
      required this.user,
      required this.restaurant})
      : super(key: key);
  final Produs produs;
  final User user;
  final Restaurant restaurant;

  @override
  State<ProductCard> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  Text customText(BuildContextcontext, String text) {
    double heightval = MediaQuery.of(context).size.height * 0.01;

    return Text(
      text,
      overflow: TextOverflow.ellipsis,
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  ProductPageWidget(
                produs: widget.produs,
                user: widget.user,
                restaurant: widget.restaurant,
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                customText(
                  context,
                  "Nume: ${widget.produs.nume}",
                ),
                (widget.produs.descriere != null &&
                        widget.produs.descriere != "")
                    ? customText(
                        context,
                        "Descriere: ${widget.produs.descriere}",
                      )
                    : const SizedBox(),
                customText(
                  context,
                  "Pret: ${widget.produs.pret}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
