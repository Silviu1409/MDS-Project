import 'package:delivery_app/MainUserPage.dart';
import 'package:delivery_app/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';
import 'repository/user_repository.dart';

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
  bool isPasswdHidden = true;
  bool isFormValid = true;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final UserRepository repository = UserRepository();

  final email_regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.title),
        ),
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
                padding: const EdgeInsets.only(top: 50.0),
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
                    //TBD mesaj de login
                    const Text("Welcome back!",
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autocorrect: false,
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
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.mail_outline),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(30),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: isPasswdHidden,
                              autocorrect: false,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
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
                                print("Form is not valid!");
                                isFormValid = true;
                                return;
                              }
                              var res =
                                  await repository.searchUser(email, password);
                              final data =
                                  res.docs.map((doc) => doc.data()).toList();
                              if (data.isEmpty ||
                                  (email == "" && password == "")) {
                                print("Could not log in!");
                              } else {
                                print("Logged in!");
                                setState(() {
                                  email = "";
                                  password = "";
                                });
                                var ref = res.docs
                                    .map((doc) => doc.reference.id)
                                    .toList()
                                    .first;
                                print(ref);
                                var date = data[0] as Map<String, dynamic>;
                                User user = User(
                                  email: date['email'] as String,
                                  password: date['password'] as String,
                                  phoneno: date['phoneno'] as String,
                                  role: date['role'] as String,
                                  username: date['username'] as String,
                                );
                                user.ref_id = ref;
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            MainUserPageWidget(user: user),
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
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
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
          ),
        ),
      ),
    );
  }
}
