// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:receipe_generator/API/api_client.dart';
import 'api_manager.dart';
import 'api_response.dart';

class ConversationOrchestrator {
  static Future<void> run(List<String> data) async {
    ApiManager.loadApiKey();

    var chatGPT = ApiClient();
    StringBuffer buffer = StringBuffer();
    data.forEach((element) {
      buffer.write('$element, ');
    });

    String message = buffer.toString();
    final String finalMessage =
        "act like a professional chef and generate all the possible dishes with instructions , dont mention an ingrediant that is not in these ingriediants $message return  it like this name, instructions and end  each step by a '.' , Catrgory choose one from these categories (breakfast,Lunch,Drinks,Pastas,Salads,Desserts,Soups)   )";

    var response = await chatGPT.sendMessage(finalMessage);

    ApiResponse.setResponse(response); // fromat the response
  }
}
