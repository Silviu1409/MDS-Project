import 'package:flutter/material.dart';
import 'models/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  final TextStyle boldStyle;

  const UserCard({Key? key, required this.user, required this.boldStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            user.email,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
          Text(
            user.password,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
          Text(
            user.username,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
          Text(
            user.phoneno,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
          Text(
            user.role,
            style: const TextStyle(
                fontFamily: 'Lato-Black',
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
