import 'dart:io';

import 'package:delivery_app/Database.dart';
import 'package:delivery_app/MainUserPage.dart';
import 'package:delivery_app/RegisterPage.dart';
import 'package:flutter/material.dart';

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> emailkey = GlobalKey<FormState>();
  GlobalKey<FormState> passwdkey = GlobalKey<FormState>();
  bool isFormValid = true;

  final email_regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  Future<bool> onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the app?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => {
              Navigator.of(context).pop(false),
            },
            child: const Text("No"),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => {
              exit(1),
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    ).then((value) => value ?? false);
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
              Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: TextFormField(
                        key: emailkey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
                        controller: controller_email,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            isFormValid = false;
                            return "* Required";
                          } else if (!email_regex.hasMatch(value)) {
                            isFormValid = false;
                            return "Not a valid email address";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: TextFormField(
                        key: passwdkey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: isPasswdHidden,
                        autocorrect: false,
                        controller: controller_password,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            isFormValid = false;
                            return "* Required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
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
                    ),
                    ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        isFormValid = true;
                        formkey.currentState!.validate();
                        if (isFormValid == false) {
                          print("Form is not valid!");
                          isFormValid = true;
                          return;
                        }
                        var res =
                            await DBProvider.db.checkUser(email, password);
                        if (res == false || (email == "" && password == "")) {
                          print("Could not log in!");
                        } else {
                          print("Logged in!");
                          setState(() {
                            email = "";
                            password = "";
                          });
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const MainUserPageWidget(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  child: const Text('Register'),
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
