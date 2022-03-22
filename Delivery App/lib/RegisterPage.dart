import 'package:delivery_app/Database.dart';
import 'package:delivery_app/LoginPage.dart';
import 'package:delivery_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPageWidget extends StatelessWidget {
  const RegisterPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Register Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  var phoneno = "";
  TextEditingController? controller_email;
  TextEditingController? controller_password;
  TextEditingController? controller_username;
  TextEditingController? controller_phoneno;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> emailkey = GlobalKey<FormState>();
  GlobalKey<FormState> passwdkey = GlobalKey<FormState>();
  GlobalKey<FormState> usernamekey = GlobalKey<FormState>();
  GlobalKey<FormState> phonenokey = GlobalKey<FormState>();

  bool isFormValid = true;
  final email_regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final phonenr_regex = RegExp(r'^07[2|3|4|5|6|7|8][0-9]{7}$');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
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
              Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                      child: TextFormField(
                        autocorrect: false,
                        key: emailkey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        autofocus: true,
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                      child: TextFormField(
                        autocorrect: false,
                        key: passwdkey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                      child: TextFormField(
                        autocorrect: false,
                        key: usernamekey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller_username,
                        onChanged: (value) {
                          setState(() {
                            username = value;
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
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.account_circle_rounded),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                      child: TextFormField(
                        autocorrect: false,
                        key: phonenokey,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller_phoneno,
                        onChanged: (value) {
                          setState(() {
                            phoneno = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            isFormValid = false;
                            return "* Required";
                          } else if (!phonenr_regex.hasMatch(value)) {
                            isFormValid = false;
                            return "Not a valid phone number";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'Phone number',
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () async {
                        isFormValid = true;
                        formkey.currentState!.validate();
                        if (isFormValid == false) {
                          print("Form is not valid!");
                          isFormValid = true;
                          return;
                        }
                        var newDBUser = User(
                            email: email,
                            password: password,
                            username: username,
                            phoneno: phoneno,
                            role: "user");
                        bool res = await DBProvider.db.newUser(newDBUser);
                        if (res == true) {
                          controller_email?.clear();
                          controller_password?.clear();
                          controller_username?.clear();
                          controller_phoneno?.clear();
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
            ],
          ),
        ),
      ),
    );
  }
}
