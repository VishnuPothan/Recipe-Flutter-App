import 'dart:ui';

import 'package:flutter/material.dart';
import './dummyData.dart';
import './models/meal.dart';
import './screen/filtersScreen.dart';
import './screen/mealDetailsScreen.dart';
import './screen/categoryMealsScreen.dart';
import './screen/tabsScreen.dart';

void main() => runApp(MyApp());

Map<int, Color> color = {
  50: Color.fromRGBO(149, 95, 91, .1),
  100: Color.fromRGBO(149, 95, 91, .2),
  200: Color.fromRGBO(149, 95, 91, .3),
  300: Color.fromRGBO(149, 95, 91, .4),
  400: Color.fromRGBO(149, 95, 91, .5),
  500: Color.fromRGBO(149, 95, 91, .6),
  600: Color.fromRGBO(149, 95, 91, .7),
  700: Color.fromRGBO(149, 95, 91, .8),
  800: Color.fromRGBO(149, 95, 91, .9),
  900: Color.fromRGBO(149, 95, 91, 1),
};

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor colorCustom = MaterialColor(0xFF955F5B, color);
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filteredData) {
    setState(() {
      _filters = filteredData;
      print(_filters);
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        } else if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        } else if (_filters['vegan'] && !meal.isVegan) {
          return false;
        } else if (_filters['vegetarian'] && !meal.isVegetarian) {
          print(meal.title);
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe',
      theme: ThemeData(
        primarySwatch: colorCustom,
        accentColor: Colors.white,
        canvasColor: Color.fromRGBO(248, 226, 184, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(149, 95, 91, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(149, 95, 91, 1),
            ),
            headline1: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
      /*onGenerateRoute: (settings){
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen());
      },*/
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => CategoryMealsScreen(_availableMeals));
      },
    );
  }
}
