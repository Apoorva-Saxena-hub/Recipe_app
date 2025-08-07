import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeScreen extends StatelessWidget {
  final String mealType;
  final Recipe recipe;

  const RecipeScreen({super.key, required this.mealType, required this.recipe});

  Future<void> _launchRecipeUrl(BuildContext context) async {
    final Uri url = Uri.parse(recipe.spoonacularSourceUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode
            .externalApplication, // or LaunchMode.inAppBrowserView for iOS
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open recipe link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(mealType)),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => _launchRecipeUrl(context),
          icon: Icon(Icons.open_in_browser),
          label: Text('Open Recipe'),
        ),
      ),
    );
  }
}
