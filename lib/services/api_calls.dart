import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

final String _baseURL = "api.spoonacular.com";
String API_KEY = DotEnv().env['SPOONACULAR_API'];

Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

Future<dynamic> callIngredients(String hint) async {
  Map<String, String> parameters = {
    'apiKey': API_KEY,
    'query': hint,
    'number': '5'
  };

  Uri uri = Uri.https(
    _baseURL,
    '/food/ingredients/autocomplete',
    parameters,
  );

  var response;

  try {
    response = await http.get(uri, headers: headers);
    final responseJson = json.decode(response.body);

    return responseJson;
  } catch (e) {
    return null;
  }
}

/* get recipes by ingredients */
Future<dynamic> callRecipes(dynamic ingredients) async {
  dynamic ingArr = [];

  String query = "";
  ingArr = ingredients.map((x) => x['name']).toList();
  query = ingArr.join(',');

  Map<String, String> parameters = {
    'apiKey': API_KEY,
    'ingredients': query,
  };

  Uri uri = Uri.https(
    _baseURL,
    '/recipes/findByIngredients',
    parameters,
  );

  var response;

  try {
    response = await http.get(uri, headers: headers);
    final responseJson = json.decode(response.body);

    return responseJson;
  } catch (e) {
    return null;
  }
}

/* get recipe by ID */
Future<dynamic> getRecipe(int id) async {
  Map<String, String> parameters = {
    'apiKey': API_KEY,
    'includeNutrition': 'false'
  };

  Uri uri = Uri.https(
    _baseURL,
    '/recipes/${id.toString()}/information',
    parameters,
  );

  var response;

  try {
    print('making http get');
    response = await http.get(uri, headers: headers);
    final responseJson = json.decode(response.body);

    return responseJson;
  } catch (e) {
    return null;
  }
}

/* get random recipes ID */
Future<dynamic> callRandomRecipes(int size) async {
  Map<String, String> parameters = {
    'apiKey': API_KEY,
    'number': size.toString(),
  };

  Uri uri = Uri.https(
    _baseURL,
    '/recipes/random',
    parameters,
  );

  var response;

  try {
    response = await http.get(uri, headers: headers);
    final responseJson = json.decode(response.body);
    print('respondeJSON');

    return responseJson['recipes'];
  } catch (e) {
    return null;
  }
}

/* get recipe search by query */
Future<dynamic> searchRecipesByQuery(String query) async {
  Map<String, String> parameters = {'apiKey': API_KEY, 'query': query};

  Uri uri = Uri.https(
    _baseURL,
    '/recipes/search',
    parameters,
  );

  var response;

  try {
    response = await http.get(uri, headers: headers);
    final responseJson = json.decode(response.body);
    print('API call request to search for recipes by query ✅');
    return responseJson['results'];
  } catch (e) {
    print('🛑🛑🛑');
    print(e);
    return e;
  }
}

/* get recipes by cuisine */
Future<dynamic> findRecipesByCuisine(String cuisine) async {
  Map<String, String> parameters = {'apiKey': API_KEY, 'cuisine': cuisine};

  Uri uri = Uri.https(
    _baseURL,
    '/recipes/complexSearch',
    parameters,
  );

  var response;

  try {
    response = await http.get(uri, headers: headers);
    final responseJson = json.decode(response.body);
    print('API call request to search for recipes by query ✅');
    return responseJson['results'];
  } catch (e) {
    print('🛑🛑🛑');
    print(e);
    return e;
  }
}
