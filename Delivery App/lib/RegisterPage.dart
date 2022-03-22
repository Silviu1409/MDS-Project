import 'package:delivery_app/Database.dart';
import 'package:delivery_app/LoginPage.dart';
import 'package:delivery_app/models/user.dart';
import 'package:flutter/material.dart';

class RegisterPageWidget extends StatelessWidget {
  const RegisterPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Register Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(title: 'Delivery app register page'),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  var email = "";
  var password = "";
  var username = "";
  var phonenr = "";
  TextEditingController? controller_email;
  TextEditingController? controller_password;
  TextEditingController? controller_username;
  TextEditingController? controller_phonenr;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
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
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              // ElevatedButton(
              //   child: const Text('Back to login'),
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.red,
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const LoginPageWidget()),
              //     );
              //   },
              // ),
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                child: Theme(
                  child: TextFormField(
                    autocorrect: false,
                    controller: controller_email,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                    autofocus: true,
                  ),
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: Colors.red,
                        ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                child: Theme(
                  child: TextFormField(
                    autocorrect: false,
                    controller: controller_password,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: Colors.red,
                        ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                child: Theme(
                  child: TextFormField(
                    autocorrect: false,
                    controller: controller_username,
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.account_circle_rounded),
                    ),
                  ),
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: Colors.red,
                        ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                child: Theme(
                  child: TextFormField(
                    autocorrect: false,
                    controller: controller_phonenr,
                    onChanged: (value) {
                      setState(() {
                        phonenr = value;
                      });
                    },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      hintText: 'Phone number',
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                    ),
                  ),
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: Colors.red,
                        ),
                  ),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: Column(children: <Widget>[
              //     const Text('Email',
              //         style: TextStyle(
              //             fontFamily: 'Lato-Black',
              //             fontSize: 20.0,
              //             fontWeight: FontWeight.w700)),
              //     TextField(
              //       autocorrect: false,
              //       controller: controller_email,
              //       onChanged: (value) {
              //         setState(() {
              //           email = value;
              //         });
              //       },
              //     ),
              //   ]),
              // ),
              // Container(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: Column(children: <Widget>[
              //     const Text(
              //       'Password',
              //       style: TextStyle(
              //           fontFamily: 'Lato-Black',
              //           fontSize: 20.0,
              //           fontWeight: FontWeight.w700),
              //     ),
              //     TextField(
              //       autocorrect: false,
              //       controller: controller_password,
              //       onChanged: (value) {
              //         setState(() {
              //           password = value;
              //         });
              //       },
              //     ),
              //   ]),
              // ),
              // Container(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: Column(children: <Widget>[
              //     const Text('Username',
              //         style: TextStyle(
              //             fontFamily: 'Lato-Black',
              //             fontSize: 20.0,
              //             fontWeight: FontWeight.w700)),
              //     TextField(
              //       autocorrect: false,
              //       controller: controller_username,
              //       onChanged: (value) {
              //         setState(() {
              //           username = value;
              //         });
              //       },
              //     ),
              //   ]),
              // ),
              // Container(
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: Column(children: <Widget>[
              //     const Text(
              //       'Phone number',
              //       style: TextStyle(
              //           fontFamily: 'Lato-Black',
              //           fontSize: 20.0,
              //           fontWeight: FontWeight.w700),
              //     ),
              //     TextField(
              //       autocorrect: false,
              //       controller: controller_phonenr,
              //       onChanged: (value) {
              //         setState(() {
              //           phonenr = value;
              //         });
              //       },
              //     ),
              //   ]),
              // ),
              ElevatedButton(
                child: const Text('Register'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () async {
                  var newDBUser = User(email: email, password: password);
                  bool res = await DBProvider.db.newUser(newDBUser);
                  if (res == true) {
                    controller_email?.clear();
                    controller_password?.clear();
                    controller_username?.clear();
                    controller_phonenr?.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                    print("Registered successfully!");
                    setState(() {});
                  } else {
                    print("Could not register!");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
