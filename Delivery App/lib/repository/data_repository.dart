import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class DataRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addUsers(User user) {
    return collection.add(user.toJson());
  }

  // void updatePet(User user) async {
  //   await collection.doc(user.ref_id).update(user.toJson());
  // }

  // void deletePet(User user) async {
  //   await collection.doc(user.ref_id).delete();
  // }
}
