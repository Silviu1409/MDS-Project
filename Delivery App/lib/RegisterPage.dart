import 'package:delivery_app/LoginPage.dart';
import 'package:delivery_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'repository/user_repository.dart';

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

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final UserRepository repository = UserRepository();

  bool isFormValid = true;
  final email_regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final phonenr_regex = RegExp(r'^07[2|3|4|5|6|7|8][0-9]{7}$');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Vrei să ieși din aplicație?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Nu'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Da'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/logo.png'),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Text("Welcome!",
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
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 20.0, 30.0, 20.0),
                            child: TextFormField(
                              autocorrect: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.mail_outline),
                              ),
                              autofocus: true,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 20.0, 30.0, 20.0),
                            child: TextFormField(
                              autocorrect: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.password),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 20.0, 30.0, 20.0),
                            child: TextFormField(
                              autocorrect: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                hintText: 'Username',
                                prefixIcon: Icon(Icons.account_circle_rounded),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 20.0, 30.0, 20.0),
                            child: TextFormField(
                              autocorrect: false,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
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
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              isFormValid = true;
                              formkey.currentState!.validate();
                              if (isFormValid == false) {
                                isFormValid = true;
                                return;
                              }
                              final newUser = User(
                                email: email,
                                password: password,
                                username: username,
                                phoneno: phoneno,
                                role: "user",
                                image: "Charactor-11",
                              );
                              repository.addUsers(newUser);
                              formkey.currentState?.reset();
                              setState(() {});
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginPageWidget()),
                                ModalRoute.withName("/login"),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPageWidget()),
                ModalRoute.withName("/login"),
              );
            },
            backgroundColor: Colors.red,
            icon: const Icon(Icons.arrow_back),
            label: const Text("Înapoi"),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
}
