import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/produs.dart';

class ProdusRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('produs');

  Stream<QuerySnapshot<Object?>> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addProdus(Produs produs) {
    return collection.add(produs.toJson());
  }

  // pt. afisare produse dintr-un restaurant
  Stream<QuerySnapshot<Object?>> getProductsforRestaurant(
      DocumentReference? ref) {
    return collection.where("restaurant", isEqualTo: ref).snapshots();
  }
}
