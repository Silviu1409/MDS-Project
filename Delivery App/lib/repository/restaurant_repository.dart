import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant.dart';

class RestaurantRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('restaurant');

  // pt. afisare toate restaurantele
  Stream<QuerySnapshot<Object?>> getRestaurants() {
    return collection.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getSearchRestaurants(String search) {
    return collection.where("name", isEqualTo: search).get().asStream();
  }

  Future<DocumentReference> addRestaurants(Restaurant restaurant) {
    return collection.add(restaurant.toJson());
  }
}
