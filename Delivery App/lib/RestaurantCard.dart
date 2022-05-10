import 'package:delivery_app/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'RestaurantPage.dart';
import 'models/user.dart';

class RestaurantCardWidget extends StatelessWidget {
  const RestaurantCardWidget(
      {Key? key, required this.restaurant, required this.user})
      : super(key: key);
  final Restaurant restaurant;
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: RestaurantCard(
        restaurant: restaurant,
        user: user,
      ),
    );
  }
}

class RestaurantCard extends StatefulWidget {
  const RestaurantCard({Key? key, required this.restaurant, required this.user})
      : super(key: key);
  final Restaurant restaurant;
  final User user;

  @override
  State<RestaurantCard> createState() => RestaurantCardState();
}

class RestaurantCardState extends State<RestaurantCard> {
  Text customText(BuildContextcontext, String text) {
    double heightval = MediaQuery.of(context).size.height * 0.01;

    return Text(
      text,
      overflow: TextOverflow.fade,
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
                  RestaurantPageWidget(
                restaurant: widget.restaurant,
                user: widget.user,
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 85.0,
              height: 85.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/${widget.restaurant.thumbnail}'),
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 15),
            Flexible(
              child: Column(
                children: <Widget>[
                  customText(
                    context,
                    widget.restaurant.nume,
                  ),
                  customText(
                    context,
                    widget.restaurant.adresa,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
