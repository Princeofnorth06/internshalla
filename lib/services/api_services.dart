import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<Map<String, dynamic>> fetchdata() async {
    var response = await http
        .get(Uri.parse('https://internshala.com/flutter_hiring/search'));
    var decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
    return decodedResponse;
  }
}
