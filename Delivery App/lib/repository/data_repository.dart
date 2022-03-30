import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class DataRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot<Object?>> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addUsers(User user) {
    return collection.add(user.toJson());
  }

  Future<QuerySnapshot<Object?>> searchUser(email, password) {
    return collection
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();
  }

  // void updatePet(User user) async {
  //   await collection.doc(user.ref_id).update(user.toJson());
  // }

  // void deletePet(User user) async {
  //   await collection.doc(user.ref_id).delete();
  // }
}
