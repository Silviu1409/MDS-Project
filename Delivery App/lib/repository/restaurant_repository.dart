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
}
