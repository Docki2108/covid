import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/models/tests.dart';
import 'package:covid/models/user.dart';

class FireStore {
  static Future<void> setUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(User().id)
        .set(User().toMap());
  }

  static Future<void> getUserData(String id) async {
    //а - докснап, получение данных
    var a = await FirebaseFirestore.instance.collection('Users').doc(id).get();

    a.data();
    User.fromMap(a.data()!);
  }

  static Future<void> setTesti(int testPoints, DateTime data) async {
    var a = await FirebaseFirestore.instance
        .collection('Tests')
        .add(test(testPoints: testPoints, data: data).toMap());
    if (User().testi == null) {
      User().testi = [];
    }
    User().testi!.add(a);
    await setUserData();
  }
}
