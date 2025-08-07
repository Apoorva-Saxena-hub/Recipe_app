import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_model.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  final String mealType;

  const RecipeDetailScreen({super.key, required this.recipe, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(mealType)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe.imageUrl),
            SizedBox(height: 16),
            Text(
              recipe.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "Summary:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(recipe.summary.replaceAll(RegExp(r'<[^>]*>'), '')), // remove HTML tags
            SizedBox(height: 16),
            Text(
              "Instructions:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            ...recipe.instructions.map((step) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text("• $step"),
            )),
          ],
        ),
      ),
    );
  }
}
