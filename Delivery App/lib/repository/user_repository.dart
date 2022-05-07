import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserRepository {
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

  //pt. profil user
  Future<DocumentSnapshot<Object?>> getUser(String userref) {
    return collection.doc(userref).get();
  }

  // getallUsers() async {
  //   var res = await collection.get();
  //   print(res.docs.map((e) => e.reference));
  // }

  //actualizare user
  void updateUser(User user) async {
    await collection.doc(user.ref?.id).update(user.toJson());
  }
}
