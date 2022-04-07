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
  Text customText(BuildContextcontext, String text) {
    double heightval = MediaQuery.of(context).size.height * 0.01;

    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Lato-Black',
          fontSize: 2 * heightval,
          color: Colors.red,
          fontWeight: FontWeight.w700),
    );
  }

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
                customText(
                  context,
                  widget.user.username,
                ),
                const SizedBox(height: 50),
                customText(
                  context,
                  "Email: ${widget.user.email}",
                ),
                customText(
                  context,
                  "Parolă: ${widget.user.password}",
                ),
                customText(
                  context,
                  "Număr de telefon: ${widget.user.phoneno}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
