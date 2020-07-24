import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  String _categoryId;
  List<Meal> _displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState() {
    //any of the context stuff we need to do in here will unfortunately
    //not work but in didChangeDependencies, it should work.
    super.initState();
  }

  //another lifecycle hook
  @override
  void didChangeDependencies() {
    //is triggered essentialy whenever the references of the state changes,
    //wich also means it will be called when the widget that belongs to
    //the state has been fully initialized and now we can tap into the context.
    //context is not available on the initState
    //modal route - on the initState-, is called before the context is setted.
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      _categoryId = routeArgs['id'];
      _categoryTitle = routeArgs['title'];

      _displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(_categoryId))
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     _displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          //return Text(_displayedMeals[index].title);
          return MealItem(
            id: _displayedMeals[index].id,
            affordability: _displayedMeals[index].affordability,
            duration: _displayedMeals[index].duration,
            complexity: _displayedMeals[index].complexity,
            imageUrl: _displayedMeals[index].imageUrl,
            title: _displayedMeals[index].title,
          );
        },
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
