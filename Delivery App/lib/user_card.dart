import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/repository/shopping_repository.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({Key? key, required this.user, required this.boldStyle})
      : super(key: key);
  final User user;
  final TextStyle boldStyle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: UserCard(user: user, boldStyle: boldStyle),
    );
  }
}

class UserCard extends StatefulWidget {
  const UserCard({Key? key, required this.user, required this.boldStyle})
      : super(key: key);
  final User user;
  final TextStyle boldStyle;
  @override
  State<UserCard> createState() => UserCardState();
}

class UserCardState extends State<UserCard> {
  ShoppingRepository repository = ShoppingRepository();
  late var shoppingcarts;

  Future<QuerySnapshot<Object?>> getshoppingcarts() async {
    var shoppingcarts =
        await repository.searchShoppingcarts(widget.user.ref_id as String);
    return shoppingcarts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            widget.user.email,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
          Text(
            widget.user.password,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
          Text(
            widget.user.username,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
          Text(
            widget.user.phoneno,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
          Text(
            widget.user.role,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
          // Text(
          //   widget.user.ref_id as String,
          //   style: const TextStyle(
          //       fontFamily: 'Lato-Black',
          //       fontSize: 20.0,
          //       color: Colors.red,
          //       fontWeight: FontWeight.w700),
          // ),
          // FloatingActionButton(  //model afisare shopping carts
          //   onPressed: () async {
          //     print(widget.user.ref_id);
          //     shoppingcarts = await getshoppingcarts();
          //     final data = shoppingcarts.docs.map((doc) => doc.data()).toList();
          //     print(data);
          //   },
          // ),
        ],
      ),
    );
  }
}
