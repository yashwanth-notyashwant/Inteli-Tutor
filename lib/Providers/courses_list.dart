import 'package:cloud_firestore/cloud_firestore.dart';

class CourseProvider {
  Future<bool> createOrUpdateCourse(String userEmail, String courseName,
      Map<String, dynamic> courseData) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('courses')
          .doc(userEmail)
          .collection('courseNames')
          .doc(courseName);

      await docRef.set(courseData, SetOptions(merge: true));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteCourse(String userEmail, String courseName) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('courses')
          .doc(userEmail)
          .collection('courseNames')
          .doc(courseName);

      await docRef.delete();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<String>?> fetchAllCourses(String userEmail) async {
    try {
      final collectionRef = FirebaseFirestore.instance
          .collection('courses')
          .doc(userEmail)
          .collection('courseNames');
      final snapshot = await collectionRef.get();

      if (snapshot.docs.isNotEmpty) {
        List<String> courseNames = snapshot.docs.map((doc) => doc.id).toList();
        return courseNames;
      } else {
        print('No courses found for this user.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
