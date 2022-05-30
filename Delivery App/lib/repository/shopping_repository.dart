import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/shoppingcart.dart';

class ShoppingRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('shoppingcarts');

  Stream<QuerySnapshot<Object?>> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addShoppingCarts(ShoppingCart shoppingcart) {
    return collection.add(shoppingcart.toJson());
  }

  Future<QuerySnapshot<Object?>> searchShoppingcarts(
      DocumentReference? userref) {
    return collection.where("user", isEqualTo: userref).get();
  }

  // pt. istoric comenzi
  Stream<QuerySnapshot<Object?>> getOrderHistory(DocumentReference? userref) {
    return collection
        .where("user", isEqualTo: userref)
        .where("finished", isEqualTo: true)
        .snapshots();
  }

  Future<String> searchActiveShoppingcarts(DocumentReference? userref) async {
    var query = collection
        .where("user", isEqualTo: userref)
        .where("finished", isEqualTo: false)
        .limit(1);
    var snapshots = await query.get();
    String doc_id = "";
    for (var doc in snapshots.docs) {
      doc_id = doc.id;
    }
    return doc_id;
  }

  Future<ShoppingCart> getShoppingCart(String cartref) async {
    var query = await collection.doc(cartref).get();
    ShoppingCart shoppingCart = ShoppingCart(
      user: query["user"],
      finished: query["finished"],
      state: query["state"],
    );
    shoppingCart.ref = query.reference;
    return shoppingCart;
  }

  Future<DocumentReference?> searchActiveShoppingcarts2(
      DocumentReference? userref) async {
    var query = collection
        .where("user", isEqualTo: userref)
        .where("finished", isEqualTo: false)
        .limit(1);
    var snapshots = await query.get();
    if (snapshots.size == 0) {
      return null;
    } else {
      return snapshots.docs.first.reference;
    }
  }

  Stream<QuerySnapshot<Object?>> getActiveDeliveries1() {
    return collection
        .where("finished", isEqualTo: true)
        .where("state", isEqualTo: 1)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> getActiveDeliveries2() {
    return collection
        .where("finished", isEqualTo: true)
        .where("state", isEqualTo: 2)
        .snapshots();
  }

  void updateCart(ShoppingCart shoppingCart) async {
    await collection.doc(shoppingCart.ref?.id).update(shoppingCart.toJson());
  }
}
