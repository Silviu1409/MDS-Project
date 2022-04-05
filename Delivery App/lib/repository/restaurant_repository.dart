import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant.dart';

class RestaurantRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('restaurant');

  // pt. afisare toate restaurantele
  Stream<QuerySnapshot<Object?>> getRestaurants() {
    return collection.snapshots();
  }

  Future<DocumentReference> addRestaurants(Restaurant restaurant) {
    return collection.add(restaurant.toJson());
  }

  // void updatePet(User user) async {
  //   await collection.doc(user.ref_id).update(user.toJson());
  // }

  // void deletePet(User user) async {
  //   await collection.doc(user.ref_id).delete();
  // }
}
