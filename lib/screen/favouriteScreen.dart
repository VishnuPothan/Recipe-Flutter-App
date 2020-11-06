import 'package:flutter/material.dart';

import '../widgets/mealItem.dart';
import '../models/meal.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavouriteScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text('You have a no favourite - start adding'),
      );
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(
          id: favouriteMeals[index].id,
          title: favouriteMeals[index].title,
          imgUrl: favouriteMeals[index].imageUrl,
          duration: favouriteMeals[index].duration,
          complexity: favouriteMeals[index].complexity,
          affordability: favouriteMeals[index].affordability,
        );
      },
      itemCount: favouriteMeals.length,
    );
  }
}
