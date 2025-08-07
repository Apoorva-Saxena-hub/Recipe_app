import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/meal_plan_model.dart';
import 'package:recipe_app/models/recipe_model.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'api.spoonacular.com';
  static const String API_KEY = '0f4acc6f5ec74e00be86e37cfc99ba72';

  //generate meal plane
  Future<MealPlan> generateMealPlan({
    required int targetCalories,
    required String diet,
  }) async {
    if (diet == 'None') diet = '';
    Map<String, String> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };
    Uri uri = Uri.https(_baseUrl, '/recipes/mealPlans/generate', parameters);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<Recipe> fetchRecipe(String id )async{
    Map<String,String> parameters = {
      'includeNutrition':'false',
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(_baseUrl,'/recipes/$id/information',parameters);
    Map<String,String> headers ={
      HttpHeaders.contentTypeHeader:'application/json',
    };
     try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe.fromMap(data);
      return recipe;
    } catch (err) {
      throw err.toString();
    }
  }
}
