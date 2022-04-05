import 'package:flutter/material.dart';
import 'models/user.dart';

class AccountPageWidget extends StatelessWidget {
  const AccountPageWidget({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: AccountPage(user: user),
    );
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<AccountPage> createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(height: 100),
                const Icon(
                  Icons.account_circle_rounded,
                  size: 100.0,
                  color: Colors.red,
                ),
                Text(
                  widget.user.username,
                  style: const TextStyle(
                      fontFamily: 'Lato-Black',
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 50),
                Text(
                  "Email: ${widget.user.email}",
                  style: const TextStyle(
                      fontFamily: 'Lato-Black',
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Parolă: ${widget.user.password}",
                  style: const TextStyle(
                      fontFamily: 'Lato-Black',
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Număr de telefon: ${widget.user.phoneno}",
                  style: const TextStyle(
                      fontFamily: 'Lato-Black',
                      fontSize: 20.0,
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
