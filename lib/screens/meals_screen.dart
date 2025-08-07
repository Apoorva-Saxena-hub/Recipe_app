import 'package:flutter/material.dart';
import 'package:recipe_app/models/meal_model.dart' show Meal;
import 'package:recipe_app/models/meal_plan_model.dart';

class MealsScreen extends StatefulWidget {
  final MealPlan mealPlan;
  const MealsScreen({super.key, required this.mealPlan});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  _buildTotalNutrientsCard() {
    return Container(
      height: 140.0,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Total Nutrients",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Calories: ${widget.mealPlan.calories.toString()} cal",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Text(
                'Protein: ${widget.mealPlan.protein.toString()} g',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fat: ${widget.mealPlan.fat.toString()} g',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Text(
                'Carbs : ${widget.mealPlan.carbs.toString()} g',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildMealCard(Meal meal, int index) {
    String mealType = _mealType(index);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 220.0,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        Container(margin: EdgeInsets.all(60.0), padding: EdgeInsets.all(10.0)),
      ],
    );
  }

  _mealType(int index) {
    switch (index) {
      case 0:
        return 'BreakFast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Snacks';
      default:
        return 'Dinner';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Meal Plan")),
      body: ListView.builder(
        itemCount: 1 + widget.mealPlan.meals.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildTotalNutrientsCard();
          }
          Meal meal = widget.mealPlan.meals[index - 1];
          return _buildMealCard(meal, index - 1);
        },
      ),
    );
  }
}
