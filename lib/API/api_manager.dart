//import 'package:dotenv/dotenv.dart';

class ApiManager {
  static late String _apikey;

  // ignore: non_constant_identifier_names
  static get ApiKey => _apikey;

  static void loadApiKey() {
    try {
      _apikey = "";
    } catch (e) {
      print("Error reading the env file");
    }
  }
}
