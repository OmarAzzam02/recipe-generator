import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:receipe_generator/API/api_manager.dart';

class ApiClient {
  final String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  Future<dynamic> sendMessage(String message) async {
    try {
      var response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiManager.ApiKey}',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content': message,
            }
          ],
        }),
      );
      if (isConnected(response)) {
        var data = jsonDecode(response.body);

        return data['choices'][0]['message']['content'];
      }
    } catch (e) {
      print("eroor connecting $e");
    }

    return "Failllledddddd";
  }

  bool isConnected(http.Response response) {
    return response.statusCode == 200;
  }
}



