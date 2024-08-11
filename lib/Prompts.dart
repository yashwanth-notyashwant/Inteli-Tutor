import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Prompts {
  Future<dynamic> prompt(String query) async {
    try {
      await dotenv.load(fileName: ".env");
      String apiKey = dotenv.env['API_KEY']!;

      // ignore: unnecessary_null_comparison
      if (apiKey == null) {
        throw Exception("API Key not found in environment variables.");
      }

      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

      final content = [Content.text(query)];
      final response = await model.generateContent(content);
      print(response);
      return response.text;
    } catch (e) {
      print('An error occurred: $e');

      return null;
    }
  }

  Future<dynamic> promptJSon(String query) async {
    try {
      await dotenv.load(fileName: ".env");
      String apiKey = dotenv.env['API_KEY']!;

      // ignore: unnecessary_null_comparison
      if (apiKey == null) {
        throw Exception("API Key not found in environment variables.");
      }

      final model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: apiKey,
          generationConfig:
              GenerationConfig(responseMimeType: 'application/json'));

      final prompt = '''
Generate a JSON response only , in other cases where JSON response for the query couldnt be created simply return an empty JSON, Now ceteate a JSON of similat structure  {
      "question":
          "An old man shoots his wife . Then he held her under the water for 5 minutes. Finally, he hangs her . But 10 minutes later they both go on a dinner date together. What is the old man's profession ?",
      "answer": "photographer",
      "stat": "F", 
    },

    The JSON response should have 10 questions in the above format 
''';
      final response = await model.generateContent([Content.text(prompt)]);
      print(response.text);

      return response.text;
    } catch (e) {
      print('An error occurred: $e');

      return null;
    }
  }
}
