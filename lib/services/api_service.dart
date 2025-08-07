import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/meal_plan_model.dart';
import 'package:recipe_app/models/recipe_model.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String _apiKey = '0f4acc6f5ec74e00be86e37cfc99ba72';

  /// Generate Meal Plan
  Future<MealPlan> generateMealPlan({
    required int targetCalories,
    required String diet,
  }) async {
    final Map<String, String> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet == 'None' ? '' : diet.toLowerCase(),
      'apiKey': _apiKey,
    };

    final uri = Uri.https(_baseUrl, '/mealplanner/generate', parameters);
    print('Request URL: $uri');

    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    try {
      final response = await http.get(uri, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MealPlan.fromMap(data);
      } else {
        throw Exception(
          'Failed to load meal plan. Status: ${response.statusCode}',
        );
      }
    } catch (error) {
      throw Exception('Error generating meal plan: $error');
    }
  }

  /// Fetch Recipe Details
  Future<Recipe> fetchRecipe(String id) async {
    final Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': _apiKey,
    };

    final uri = Uri.https(_baseUrl, '/recipes/$id/information', parameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Recipe.fromMap(data);
      } else {
        throw Exception(
          'Failed to load recipe. Status: ${response.statusCode}',
        );
      }
    } catch (error) {
      throw Exception('Error fetching recipe: $error');
    }
  }
}
