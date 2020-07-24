import 'package:flutter/material.dart';

import '../models/meal.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some :D',
            style: Theme.of(context).textTheme.headline6),
      );
    } else
      return ListView.builder(
        itemBuilder: (ctx, index) {
          //return Text(favoriteMeals[index].title);
          return MealItem(
            id: favoriteMeals[index].id,
            affordability: favoriteMeals[index].affordability,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            imageUrl: favoriteMeals[index].imageUrl,
            title: favoriteMeals[index].title,
          );
        },
        itemCount: favoriteMeals.length,
      );
  }
}
