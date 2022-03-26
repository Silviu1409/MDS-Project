import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'models/user.dart';

class MainUserPageWidget extends StatelessWidget {
  const MainUserPageWidget({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App main page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainUserPage(title: 'Delivery app main page', user: user),
    );
  }
}

class MainUserPage extends StatefulWidget {
  const MainUserPage({Key? key, required this.title, required this.user})
      : super(key: key);
  final User user;
  final String title;

  @override
  State<MainUserPage> createState() => MainUserPageState();
}

class MainUserPageState extends State<MainUserPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
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
            Text("Hello, ${widget.user.username}!",
                style: const TextStyle(
                    fontFamily: 'Lato-Black',
                    fontSize: 32.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w700)),
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
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acasa',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Descopera',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cos',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Comenzi',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Cont',
            backgroundColor: Colors.red,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      ),
    );
  }
}