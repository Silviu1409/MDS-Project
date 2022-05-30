import 'package:delivery_app/MainDeliveryPage.dart';
import 'package:delivery_app/models/shoppingcart.dart';
import 'package:delivery_app/repository/shopping_repository.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

class OrderDeliveryCardWidget extends StatelessWidget {
  const OrderDeliveryCardWidget({
    Key? key,
    required this.shoppingCart,
    required this.user,
  }) : super(key: key);
  final ShoppingCart shoppingCart;
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OrderDeliveryCard(
        shoppingCart: shoppingCart,
        user: user,
      ),
    );
  }
}

class OrderDeliveryCard extends StatefulWidget {
  const OrderDeliveryCard({
    Key? key,
    required this.shoppingCart,
    required this.user,
  }) : super(key: key);
  final ShoppingCart shoppingCart;
  final User user;

  @override
  State<OrderDeliveryCard> createState() => OrderDeliveryCardState();
}

class OrderDeliveryCardState extends State<OrderDeliveryCard> {
  final ShoppingRepository repository_cart = ShoppingRepository();

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
      margin: const EdgeInsets.fromLTRB(0, 0, 30, 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: InkWell(
          onTap: () {},
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              customText(
                context,
                "Plasată pe: ${widget.shoppingCart.datetime}",
              ),
              const SizedBox(
                height: 15,
              ),
              customText(
                context,
                "Adresă de livrare: ${widget.shoppingCart.address}",
              ),
              const SizedBox(
                height: 15,
              ),
              customText(
                context,
                "Total: ${widget.shoppingCart.total.toString()} lei",
              ),
              widget.shoppingCart.state == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            MainDeliveryPageState.rejected_orders
                                .add(widget.shoppingCart.ref!.id);
                            MainDeliveryPageState.modif_order = true;
                          },
                          icon: const Icon(Icons.cancel_outlined),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            widget.shoppingCart.state = 2;
                            repository_cart.updateCart(widget.shoppingCart);
                          },
                          icon: const Icon(Icons.check),
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            widget.shoppingCart.state = 3;
                            repository_cart.updateCart(widget.shoppingCart);
                          },
                          icon: const Icon(Icons.check),
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
