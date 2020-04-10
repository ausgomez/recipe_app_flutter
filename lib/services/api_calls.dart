import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

final String _baseURL = "api.spoonacular.com";
const String API_KEY = "e33830a4c39a4837ba390fb050cd284c";

Future<dynamic> callIngredients(String hint) async {
  Map<String, String> parameters = {
    'apiKey': API_KEY,
    'query': hint,
    'number': '5'
  };

  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Uri uri = Uri.https(
    _baseURL,
    '/food/ingredients/autocomplete',
    parameters,
  );

  var response = await http.get(uri, headers: headers);

  final responseJson = json.decode(response.body);

  return responseJson;
}
