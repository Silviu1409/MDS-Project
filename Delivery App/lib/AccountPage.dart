import 'package:flutter/material.dart';
import 'models/user.dart';
import 'repository/user_repository.dart';

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
  var username = "";
  var email = "";
  var password = "";
  var phoneno = "";
  bool isPasswdHidden = true;
  int i = 0;
  final UserRepository repository = UserRepository();
  final List images = [
    "Charactor-11",
    "Charactor-12",
    "Charactor-13",
    "Charactor-14",
    "Charactor-15",
    "Charactor-16",
    "Charactor-17",
    "Charactor-18",
    "Charactor-19",
    "Charactor-20",
  ];
  Map<String, bool> isselected = {
    "Charactor-11": false,
    "Charactor-12": false,
    "Charactor-13": false,
    "Charactor-14": false,
    "Charactor-15": false,
    "Charactor-16": false,
    "Charactor-17": false,
    "Charactor-18": false,
    "Charactor-19": false,
    "Charactor-20": false,
  };

  @override
  void initState() {
    super.initState();
    username = widget.user.username;
    email = widget.user.email;
    password = widget.user.password;
    phoneno = widget.user.phoneno;
    isselected[widget.user.image] = true;
  }

  Text customText(BuildContext context, String text) {
    double heightval = MediaQuery.of(context).size.height * 0.01;

    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Lato-Black',
          fontSize: 2.25 * heightval,
          color: Colors.black,
          fontWeight: FontWeight.w700),
    );
  }

  GridTile tile(String image, BuildContext context) {
    if (isselected[image.split('/')[2].split('.')[0]] == false) {
      return GridTile(
        child: IconButton(
          icon: Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          onPressed: () {
            setState(
              () {
                isselected[widget.user.image] = false;
                isselected[image.split('/')[2].split('.')[0]] = true;
                widget.user.image = image.split('/')[2].split('.')[0];
                repository.updateUser(widget.user);
              },
            );
            Navigator.of(context).pop();
          },
        ),
      );
    } else {
      return GridTile(
        header: const Icon(Icons.verified),
        child: IconButton(
          icon: Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          onPressed: () {
            setState(
              () {},
            );
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 100),
                  const Text(
                    "Detalii cont",
                    style: TextStyle(
                        fontFamily: 'Lato-Black',
                        fontSize: 30,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 25),
                  Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                            'images/user icons/${widget.user.image}.jpg'),
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      ),
                      Positioned(
                        bottom: 86,
                        right: 20,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              height: 25.0,
                              width: 25.0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 25,
                                ),
                                onPressed: () => showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                    contentPadding: const EdgeInsets.all(10.0),
                                    content: GestureDetector(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: GridView.count(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.0,
                                          padding: const EdgeInsets.all(10.0),
                                          mainAxisSpacing: 10.0,
                                          crossAxisSpacing: 10.0,
                                          children: <String>[
                                            'images/user icons/${images[0]}.jpg',
                                            'images/user icons/${images[1]}.jpg',
                                            'images/user icons/${images[2]}.jpg',
                                            'images/user icons/${images[3]}.jpg',
                                            'images/user icons/${images[4]}.jpg',
                                            'images/user icons/${images[5]}.jpg',
                                            'images/user icons/${images[6]}.jpg',
                                            'images/user icons/${images[7]}.jpg',
                                            'images/user icons/${images[8]}.jpg',
                                            'images/user icons/${images[9]}.jpg',
                                          ]
                                              .map(
                                                  (data) => tile(data, context))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 30),
                      const Icon(Icons.email),
                      const SizedBox(width: 15),
                      customText(
                        context,
                        'Email: ${widget.user.email}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.account_circle_rounded),
                            const SizedBox(width: 15),
                            customText(
                              context,
                              "Username",
                            ),
                            const SizedBox(width: 15),
                            const Icon(Icons.edit),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30.0, 15, 30.0, 0),
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          autocorrect: false,
                          initialValue: username,
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          onFieldSubmitted: (value) {
                            widget.user.username = value;
                            repository.updateUser(widget.user);
                            username = value;
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.password),
                            const SizedBox(width: 15),
                            customText(
                              context,
                              "Parolă",
                            ),
                            const SizedBox(width: 15),
                            const Icon(Icons.edit),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30.0, 15, 30.0, 0),
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          autocorrect: false,
                          initialValue: password,
                          obscureText: isPasswdHidden,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          onFieldSubmitted: (value) {
                            widget.user.password = value;
                            repository.updateUser(widget.user);
                            password = value;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
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
                    ],
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.phone),
                            const SizedBox(width: 15),
                            customText(
                              context,
                              "Număr de telefon",
                            ),
                            const SizedBox(width: 15),
                            const Icon(Icons.edit),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30.0, 15, 30.0, 0),
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          autocorrect: false,
                          initialValue: phoneno,
                          onChanged: (value) {
                            setState(() {
                              phoneno = value;
                            });
                          },
                          onFieldSubmitted: (value) {
                            widget.user.phoneno = value;
                            repository.updateUser(widget.user);
                            phoneno = value;
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
