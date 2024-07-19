import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intellitutor/Models/AuthUser.dart';

class UserDataProvider {
  Future<AuthUser?> getUserData(String userEmail) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(userEmail);
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        return AuthUser.fromMap(data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> createOrUpdateUserDoc(AuthUser user, String userEmail) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(userEmail);
      final data = user.toMap();
      await docRef.set(data, SetOptions(merge: true));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> checkUserExists(String userEmail) async {
    final user = await getUserDataExists(userEmail);
    return user != null;
  }

  Future<AuthUser?> getUserDataExists(String userEmail) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(userEmail);
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        return AuthUser.fromMap(data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
