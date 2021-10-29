import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<bool> adduser(String name, String email, String photoURL
      ) async {
    bool status = false;
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      users.add({
        'name': name,
        'email': email,
        'photoURL': photoURL,
      }).then((value) => print("User Added"));
      status = true;
    } catch (e) {
      status = false;
      print(e);
    }
    return status;
  }

  Future<Map<dynamic, dynamic>> getusermap(String email) async {
    Map<dynamic, dynamic> user = {};
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    querySnapshot.docs.forEach((userDoc) {
      if (userDoc["email"] == email) {
        user = userDoc.data() as Map;
        print(user);
      }
    });
    return user;
  }
}
