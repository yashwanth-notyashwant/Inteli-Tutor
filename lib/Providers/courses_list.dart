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

      // Check if sections is null
      if (sections == null || sections == "null") {
        print("The sections are null.");
        return false;
      }

      // Inspect and print the raw response
      print("Raw response: $sections");

      // Clean and process the response
      String cleanedStr = sections.trim();

      // Remove surrounding brackets if they exist
      if (cleanedStr.startsWith('[') && cleanedStr.endsWith(']')) {
        cleanedStr = cleanedStr.substring(1, cleanedStr.length - 1).trim();
      }

      // Split the string by commas and clean up each section
      List<String> list = cleanedStr
          .split(',')
          .map((s) => s.trim().replaceAll(RegExp(r'^"|"$'), ''))
          .toList();

      if (list.isEmpty || list[0] == 'null' || list.length == 1) {
        print("The list is empty or invalid.");
        return false;
      } else {
        fields = list;
      }

      for (String field in fields) {
        courseData[field] = '';
      }

      courseData['reference'] = fields;
      courseData['query'] =
          "Generate a paragraph of about 500-1000 words about the section name, the word limit isn't fixed but should be based on content. This comes under the topic of $courseName, the complexity should be $complexity, and the end goal of this section is to $endGoal. The response should be in a paragraph format.";

      // Update Firestore
      final docRef = FirebaseFirestore.instance
          .collection('courses')
          .doc(userEmail)
          .collection('courseNames')
          .doc(courseName);

      await docRef.set(courseData, SetOptions(merge: true));

      return true;
    } catch (e) {
      print("Error: $e");
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

  Future<List<String>?> sectionNameFetcher(
      String userEmail, String courseName) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('courses')
          .doc(userEmail)
          .collection('courseNames')
          .doc(courseName);

      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('reference')) {
          List<String> reference = List<String>.from(data['reference']);
          return reference;
        } else {
          print("Field 'reference' does not exist.");
          return null;
        }
      } else {
        print("Document does not exist.");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<String?> specificSectionFieldFetcher(String userEmail,
      String courseName, String sectionNameORQueryName) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('courses')
          .doc(userEmail)
          .collection('courseNames')
          .doc(courseName);

      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey(sectionNameORQueryName)) {
          String fieldValue = data[sectionNameORQueryName];
          return fieldValue;
        } else {
          print("Field '$sectionNameORQueryName' does not exist.");
          return null;
        }
      } else {
        print("Document does not exist.");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> updateSpecificFieldDesc(String userEmail, String courseName,
      String fieldName, String desc) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('courses')
          .doc(userEmail)
          .collection('courseNames')
          .doc(courseName);

      await docRef.update({fieldName: desc});
      print("Field '$fieldName' updated successfully.");
    } catch (e) {
      print("Error updating field: $e");
    }
  }

  Future<String> createDescAI(
      String email, String query, String sectionName, String courseName) async {
    Prompts promptInstance = Prompts();
    dynamic sections = await promptInstance
        .prompt("The section name is $sectionName " + " " + query);
    if (sections == null || sections == "") {
      return "";
    }
    await updateSpecificFieldDesc(
        email, courseName, sectionName, sections.toString());
    return sections.toString();
  }
}
