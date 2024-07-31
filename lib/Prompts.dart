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
}
