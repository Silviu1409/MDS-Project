import 'package:delivery_app/repository/orderitem_repository.dart';
import 'package:flutter/material.dart';

import 'ShoppingCartPage.dart';
import 'models/orderitem.dart';

class ShoppingCartProductCardWidget extends StatelessWidget {
  const ShoppingCartProductCardWidget(
      {Key? key, required this.detalii_produs, required this.state})
      : super(key: key);
  final Map<String, dynamic> detalii_produs;
  final ShoppingCartPageState state;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ShoppingCartProductCard(
        detalii_produs: detalii_produs,
        state: state,
      ),
    );
  }
}

class ShoppingCartProductCard extends StatefulWidget {
  const ShoppingCartProductCard(
      {Key? key, required this.detalii_produs, required this.state})
      : super(key: key);
  final Map<String, dynamic> detalii_produs;
  final ShoppingCartPageState state;

  @override
  State<ShoppingCartProductCard> createState() =>
      ShoppingCartProductCardState();
}

class ShoppingCartProductCardState extends State<ShoppingCartProductCard> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    customText(
                      context,
                      "Nume: ${widget.detalii_produs["nume"]}",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: const Icon(Icons.highlight_remove),
                      iconSize: 30,
                      onPressed: () {
                        repository_orderitem.removeOrderItem(orderItem!);
                        ShoppingCartPageState.loading = true;
                        widget.state.shoppingcartdet = [];
                        widget.state.getproducts();
                        widget.state.setState(() {});
                        setState(() {});
                      },
                    ),
                  ],
                ),
                customText(
                  context,
                  "Preț: ${widget.detalii_produs["pret"]} lei",
                ),
                customText(
                  context,
                  "Cantitate: ",
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        if (orderItem!.cantitate > 1) {
                          orderItem?.cantitate -= 1;
                          repository_orderitem.updateOrderItem(orderItem!);
                          widget.state.getproducts();
                          widget.state.setState(() {});
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: MediaQuery.of(context).size.height * 0.01 * 3.5,
                    ),
                    customText(
                      context,
                      "${widget.detalii_produs["cantitate"]}",
                    ),
                    IconButton(
                      onPressed: () {
                        orderItem?.cantitate += 1;
                        repository_orderitem.updateOrderItem(orderItem!);
                        widget.state.getproducts();
                        widget.state.setState(() {});
                        setState(() {});
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: MediaQuery.of(context).size.height * 0.01 * 3.5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
