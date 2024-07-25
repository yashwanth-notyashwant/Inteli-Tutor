import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intellitutor/Consts/constants.dart';
import 'package:intellitutor/prompts.dart';

class CourseProvider {
  Future<bool> createOrUpdateCourse(
    String userEmail,
    String courseName,
    Map<String, dynamic> courseData,
    String complexity,
    String endGoal,
  ) async {
    try {
      List<String> fields = [];
      Prompts promptInstance = Prompts();
      dynamic sections = await promptInstance.prompt(
          "$SECTION_NAMES_GENERATOR1 $courseName $SECTION_NAMES_GENERATOR2 $complexity $SECTION_NAMES_GENERATOR3 $endGoal");

      String cleanedStr = sections.substring(1, sections.length - 1).trim();
      List<String> list = cleanedStr
          .split(',')
          .map((s) => s.trim().replaceAll(RegExp(r'^"|"$'), ''))
          .toList();

      if (list.isEmpty || sections == null) {
        return false;
      } else {
        fields = list;
      }

      for (String field in fields) {
        courseData[field] = '';
      }

      courseData['reference'] = fields;
      courseData['query'] =
          "Generate a paragraph of about 300-600 words about the section name, the word limit isnt fixed but should be based on content, This comes under the topic of $courseName, the complexity should be $complexity and the endgoal of this section is to $endGoal . The response should be in a paragraph format ";

      // Update Firestore
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
