import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/orderitem.dart';

class OrderItemRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('orderitem');

  Stream<QuerySnapshot<Object?>> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addOrderItem(OrderItem orderitem) {
    return collection.add(orderitem.toJson());
  }

  Future<String> checkifprodinOrderItems(
      String shoppingcartref, String prodref) async {
    DocumentReference ref_shopping = FirebaseFirestore.instance
        .collection('shoppingcarts')
        .doc(shoppingcartref);
    DocumentReference ref_prod =
        FirebaseFirestore.instance.collection('produs').doc(prodref);
    QuerySnapshot<Object?> orderitems = await collection
        .where("shoppingcart", isEqualTo: ref_shopping)
        .where("produs", isEqualTo: ref_prod)
        .get();
    if (orderitems.size != 0) {
      return orderitems.docs.first.id;
    } else {
      return "";
    }
  }

  void updateOrderItem(OrderItem orderItem) async {
    await collection.doc(orderItem.ref?.id).update(orderItem.toJson());
  }

  void removeOrderItem(OrderItem orderItem) async {
    await collection.doc(orderItem.ref?.id).delete();
  }

  Future<OrderItem> getOrderItem(String ref_orderitem) async {
    var date = (await collection.doc(ref_orderitem).get());
    OrderItem orderItem = OrderItem(
      produs: date["produs"],
      shoppingcart: date["shoppingcart"],
      cantitate: date["cantitate"],
    );
    orderItem.ref = collection.doc(ref_orderitem);

    return orderItem;
  }

  Future<List<OrderItem>> getOrderItemsforShoppingCart(
      String shoppingcartref) async {
    DocumentReference ref_shopping = FirebaseFirestore.instance
        .collection('shoppingcarts')
        .doc(shoppingcartref);
    var date =
        (await collection.where("shoppingcart", isEqualTo: ref_shopping).get());
    List<OrderItem> lista = [];
    for (var x in date.docs) {
      OrderItem orderItem = OrderItem(
        produs: x["produs"],
        shoppingcart: x["shoppingcart"],
        cantitate: x["cantitate"],
      );
      orderItem.ref = x.reference;
      lista.add(orderItem);
    }
    return lista;
  }

  Future<QuerySnapshot<Object?>> searchOrderItem(
      String shoppingcartref, String produsref) {
    DocumentReference ref_shopping = FirebaseFirestore.instance
        .collection('shoppingcarts')
        .doc(shoppingcartref);
    DocumentReference ref_produs =
        FirebaseFirestore.instance.collection('produs').doc(produsref);
    return collection
        .where("produs", isEqualTo: ref_produs)
        .where("shoppingcart", isEqualTo: ref_shopping)
        .get();
  }

  // afisare produse pt. shopping cart
  Future<List<DocumentSnapshot<Object?>>> getItemsforShoppingCart(
      String shoppingcartref) async {
    DocumentReference ref_shopping = FirebaseFirestore.instance
        .collection('shoppingcarts')
        .doc(shoppingcartref);
    QuerySnapshot<Object?> orderitems =
        await collection.where("shoppingcart", isEqualTo: ref_shopping).get();
    List<DocumentReference> prodref = [];
    for (QueryDocumentSnapshot doc in orderitems.docs) {
      DocumentReference ref = doc.get("produs");
      prodref.add(ref);
    }
    List<DocumentSnapshot> list_prod = [];
    for (DocumentReference ref in prodref) {
      DocumentSnapshot prod = await ref.get();
      list_prod.add(prod);
    }
    return list_prod;
  }

  // afisare cantitati pt. shopping cart
  Future<List<int>> getCant(String shoppingcartref) async {
    DocumentReference ref_shopping = FirebaseFirestore.instance
        .collection('shoppingcarts')
        .doc(shoppingcartref);
    QuerySnapshot<Object?> orderitems =
        await collection.where("shoppingcart", isEqualTo: ref_shopping).get();
    List<int> cantitati = [];
    for (QueryDocumentSnapshot doc in orderitems.docs) {
      int cant = doc.get("cantitate");
      cantitati.add(cant);
    }
    return cantitati;
  }
}
