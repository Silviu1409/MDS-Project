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

  Future<QuerySnapshot<Object?>> searchShoppingcarts(String userref) {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(userref);
    return collection.where("user", isEqualTo: ref).get();
  }

  // pt. istoric comenzi
  Future<QuerySnapshot<Object?>> getOrderHistory(String? userref) {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(userref);
    return collection
        .where("user", isEqualTo: ref)
        .where("finished", isEqualTo: true)
        .get();
  }

  Future<String> searchActiveShoppingcarts(String? userref) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(userref);
    var query = collection
        .where("user", isEqualTo: ref)
        .where("finished", isEqualTo: false)
        .limit(1);
    var snapshots = await query.get();
    String doc_id = "";
    for (var doc in snapshots.docs) {
      doc_id = doc.id;
    }
    return doc_id;
  }

  // void updatePet(User user) async {
  //   await collection.doc(user.ref_id).update(user.toJson());
  // }

  // void deletePet(User user) async {
  //   await collection.doc(user.ref_id).delete();
  // }
}
