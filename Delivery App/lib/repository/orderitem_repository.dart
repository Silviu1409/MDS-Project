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

  Future<QuerySnapshot<Object?>> searchOrderItem(
      String shoppingcartref, String produsref) {
    DocumentReference ref_shopping = FirebaseFirestore.instance
        .collection('shoppingcarts')
        .doc(shoppingcartref);
    DocumentReference ref_produs =
        FirebaseFirestore.instance.collection('produs').doc(produsref);
    return collection
        .where("product", isEqualTo: ref_produs)
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

  // void updatePet(User user) async {
  //   await collection.doc(user.ref_id).update(user.toJson());
  // }

  // void deletePet(User user) async {
  //   await collection.doc(user.ref_id).delete();
  // }
}