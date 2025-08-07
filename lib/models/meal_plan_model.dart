import 'package:recipe_app/models/meal_model.dart';

class MealPlan {
  final List<Meal> meals;
  final double calories;
  final double carbs;
  final double fat;
  final double protein;

  MealPlan({
    required this.meals,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  factory MealPlan.fromMap(Map<String, dynamic> map) {
    List<Meal> meals = [];

    if (map['meals'] != null && map['meals'] is List) {
      for (var mealMap in map['meals']) {
        meals.add(Meal.fromMap(mealMap));
      }
    }

    final nutrients = map['nutrients'] ?? {};

    return MealPlan(
      meals: meals,
      calories: _toDouble(nutrients['calories']),
      carbs: _toDouble(nutrients['carbs']),
      fat: _toDouble(nutrients['fat']),
      protein: _toDouble(nutrients['protein']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
