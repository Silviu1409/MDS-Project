import 'package:flutter/material.dart';
import 'LoginPage.dart';

class MainUserPageWidget extends StatelessWidget {
  const MainUserPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App main page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MainUserPage(title: 'Delivery app main page'),
    );
  }
}

class MainUserPage extends StatefulWidget {
  const MainUserPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainUserPage> createState() => MainUserPageState();
}

class MainUserPageState extends State<MainUserPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(children: <Widget>[
            ElevatedButton(
              child: const Text('Back to login'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const LoginPageWidget(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
