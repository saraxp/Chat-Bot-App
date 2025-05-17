/*

File to handle Gemini API

 */

import 'dart:convert';
import 'package:http/http.dart' as http;


class GeminiApiService{
  //API Constants
  static const String _baseUrl = 'YOUR API URL';
  static const String _apiKey = 'YOUR API KEY';

  Future<String> sendMessage(String content) async {
    try {
      //make POST req to Gemini API
      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": content}
              ]
            }
          ]
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return 'Failed to get response: ${response.statusCode}';
      }
    }
    catch(e) {
      return 'API Error: $e';
    }
  }

}



