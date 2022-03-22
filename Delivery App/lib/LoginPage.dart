import 'package:delivery_app/Database.dart';
import 'package:delivery_app/MainUserPage.dart';
import 'package:delivery_app/RegisterPage.dart';
import 'package:delivery_app/models/user.dart';
import 'package:flutter/material.dart';

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(title: 'Delivery app login page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  var email = "";
  var password = "";
  TextEditingController? controller_email;
  TextEditingController? controller_password;
  bool isPasswdHidden = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.red,
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              //TBD mesaj de login
              const Text("Title",
                  style: TextStyle(
                      fontFamily: 'Lato-Black',
                      fontSize: 32.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w700)),
              Container(
                padding: const EdgeInsets.all(30),
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
                  ),
                  data: Theme.of(context).copyWith(
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: Colors.red,
                        ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30),
                child: Theme(
                  child: TextFormField(
                    obscureText: isPasswdHidden,
                    autocorrect: false,
                    controller: controller_password,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswdHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswdHidden = !isPasswdHidden;
                          });
                        },
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
              //   padding: const EdgeInsets.all(30),
              //   child: Column(children: <Widget>[
              //     const Text('Email',
              //         style: TextStyle(
              //             fontFamily: 'Lato-Black',
              //             fontSize: 32.0,
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
              //   padding: const EdgeInsets.all(30),
              //   child: Column(children: <Widget>[
              //     const Text(
              //       'Password',
              //       style: TextStyle(
              //           fontFamily: 'Lato-Black',
              //           fontSize: 32.0,
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
              ElevatedButton(
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () async {
                  var user = User(email: email, password: password);
                  var res = await DBProvider.db.checkUser(user);
                  if (res == true) {
                    print("Logged in!");
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const MainUserPageWidget(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  } else {
                    print("Could not log in!");
                  }
                },
                // onPressed: () async {
                //   var user = User(email: email, password: password);
                //   var res = await DBProvider.db.checkUser(user);
                //   if (res == true) {
                //     print("Logged in!");
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const MainUserPageWidget()),
                //     );
                //   } else
                //     print("Could not log in!");
                // },
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  child: const Text('Register'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const RegisterPageWidget(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Route2 extends StatelessWidget {
//   late Map<String, String> newUser = {};
//   late Future userFuture = getUsers();

//   Route2({Key? key}) : super(key: key);

//   getUsers() async {
//     final _userData = await DBProvider.db.getUsers();
//     return _userData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Future.value(false),
//       child: Scaffold(
//         // appBar: AppBar(
//         //   title: const Text('2nd route'),
//         // ),
//         body: Container(
//           padding: const EdgeInsets.only(top: 25.0),
//           child: Column(children: <Widget>[
//             ElevatedButton(
//               child: const Text('Go back'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const LoginPageWidget()),
//                 );
//               },
//             ),
//             ElevatedButton(
//               child: const Text('Get users'),
//               onPressed: () async {
//                 userFuture = await getUsers();
//                 List list = userFuture as List;
//                 print(list);
//               },
//             ),
//             // FutureBuilder(
//             //   future: userFuture,
//             //   builder: (_, userData) {
//             //     switch (userData.connectionState) {
//             //       case ConnectionState.none:
//             //         return Container();
//             //       case ConnectionState.waiting:
//             //         return Container();
//             //       case ConnectionState.active:
//             //       case ConnectionState.done:
//             //         if (!newUser.containsKey('username')) {
//             //           newUser = Map<String, String>.from(userData.data);
//             //         }
//             //         return Column(children: <Widget>[
//             //           Text(newUser['username'].toString()),
//             //           Text(newUser['password'].toString())
//             //         ]);
//             //     }
//             //   },
//             // )
//           ]),
//         ),
//       ),
//     );
//   }
// }
