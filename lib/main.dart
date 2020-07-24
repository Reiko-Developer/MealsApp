import 'package:flutter/material.dart';

import './dummy_data.dart';

import './models/meal.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';

void main() {
  runApp(MyApp());
}

//to manage the Fitlters Screen on the main.dart i need to convert it to
//a statefullWidget.
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (!_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (!_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    print('toogle');
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    setState(() {
      print('Exists $existingIndex');
      if (existingIndex >= 0) {
        _favoriteMeals.removeAt(existingIndex);
      } else
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    });
  }

  bool isMealFavorite(String id) {
    //any returns true if i find any element where this is true;
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/', //default is '/'
      routes: {
        '/': (ctx) => TabScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      //Load the CategoriesScreen page for any initiateed route
      //that is not registered on the routes array.
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      // //Is reached when flutter fails to build a screen with all other methods.
      //Or when you don't define routes and don't use onGeneratedRoute.
      //So as the last resource before the runtime error, flutter tries to use
      //this method to show something on the screen.
      onUnknownRoute: (settings) {
        print('Unknown Route');
        print(settings);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
