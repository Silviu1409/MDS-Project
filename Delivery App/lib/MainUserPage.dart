import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/repository/orderitem_repository.dart';
import 'package:delivery_app/repository/produs_repository.dart';
import 'package:delivery_app/repository/restaurant_repository.dart';
import 'package:delivery_app/repository/shopping_repository.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'models/user.dart';
import 'user_card.dart';
import 'repository/user_repository.dart';

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

  final UserRepository repository_user = UserRepository();
  final ShoppingRepository repository_cart = ShoppingRepository();
  final OrderItemRepository repository_orderitem = OrderItemRepository();
  final RestaurantRepository repository_restaurant = RestaurantRepository();
  final ProdusRepository repository_produs = ProdusRepository();

  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

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
            Center(
              child: Text("Hello, ${widget.user.username}!",
                  style: const TextStyle(
                      fontFamily: 'Lato-Black',
                      fontSize: 32.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 25),
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

            // Text(
            //   widget.user.email,
            //   style: const TextStyle(
            //       fontFamily: 'Lato-Black',
            //       fontSize: 20.0,
            //       color: Colors.red,
            //       fontWeight: FontWeight.w700),
            // ),
            // Text(
            //   widget.user.password,
            //   style: const TextStyle(
            //       fontFamily: 'Lato-Black',
            //       fontSize: 20.0,
            //       color: Colors.red,
            //       fontWeight: FontWeight.w700),
            // ),
            // Text(
            //   widget.user.username,
            //   style: const TextStyle(
            //       fontFamily: 'Lato-Black',
            //       fontSize: 20.0,
            //       color: Colors.red,
            //       fontWeight: FontWeight.w700),
            // ),
            // Text(
            //   widget.user.phoneno,
            //   style: const TextStyle(
            //       fontFamily: 'Lato-Black',
            //       fontSize: 20.0,
            //       color: Colors.red,
            //       fontWeight: FontWeight.w700),
            // ),
            // Text(
            //   widget.user.role,
            //   style: const TextStyle(
            //       fontFamily: 'Lato-Black',
            //       fontSize: 20.0,
            //       color: Colors.red,
            //       fontWeight: FontWeight.w700),
            // ),
            // Text(
            //   widget.user.ref_id as String,
            //   style: const TextStyle(
            //       fontFamily: 'Lato-Black',
            //       fontSize: 20.0,
            //       color: Colors.red,
            //       fontWeight: FontWeight.w700),
            // ),

            // StreamBuilder<QuerySnapshot>(
            //     stream: repository.getStream(),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) return const LinearProgressIndicator();

            //       return _buildList(context, snapshot.data?.docs ?? []);
            //     }),
          ]),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () async {
                String cart_ref = await repository_cart
                    .searchActiveShoppingcarts(widget.user.ref_id);
                if (cart_ref != "") {
                  List<DocumentSnapshot<Object?>> produse =
                      await repository_orderitem
                          .getItemsforShoppingCart(cart_ref);
                  List<int> cant = await repository_orderitem.getCant(cart_ref);
                  double pret_total = 0;
                  Map<String, List<dynamic>> shoppingcartitems = {
                    "nume": [],
                    "pret": [],
                    "cantitate": [],
                  };
                  int i = 0;
                  for (DocumentSnapshot doc in produse) {
                    double pret = doc.get("pret");
                    int c = cant[i];
                    shoppingcartitems["nume"]?.add(doc.get("nume"));
                    shoppingcartitems["pret"]?.add(pret);
                    shoppingcartitems["cantitate"]?.add(c);
                    pret_total += pret * c;
                    i += 1;
                  }
                  print("Shopping cart:\n$shoppingcartitems");
                  print("Pret total: $pret_total");
                } else {
                  print("Niciun shopping cart activ.");
                }
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.shopping_cart),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () async {
                QuerySnapshot history =
                    await repository_cart.getOrderHistory(widget.user.ref_id);
                if (history.size != 0) {
                  for (QueryDocumentSnapshot comanda in history.docs) {
                    print(comanda.data());
                  }
                } else {
                  print("Nicio comanda data.");
                }
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.list_alt),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () async {
                var restaurante = await repository_restaurant.getRestaurants();
                if (restaurante.size == 0) {
                  print("Niciun restaurant");
                } else {
                  for (QueryDocumentSnapshot restaurant in restaurante.docs) {
                    print(restaurant.data());
                  }
                }
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.restaurant),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () async {
                var restaurante = await repository_restaurant.getRestaurants();
                if (restaurante.size == 0) {
                  print("Niciun restaurant");
                } else {
                  List<String> id_res = [];
                  for (QueryDocumentSnapshot restaurant in restaurante.docs) {
                    id_res.add(restaurant.id);
                  }
                  for (var res in id_res) {
                    var produse =
                        await repository_produs.getProductsforRestaurant(res);
                    if (produse.size == 0) {
                      print("Niciun produs");
                    } else {
                      for (QueryDocumentSnapshot produs in produse.docs) {
                        print(produs.data());
                      }
                    }
                  }
                }
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.restaurant_menu),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () async {
                print(widget.user.toJson());
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.account_circle),
            ),
          ],
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

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final user = User.fromSnapshot(snapshot);

    return UserCard(user: user, boldStyle: boldStyle);
  }
}
