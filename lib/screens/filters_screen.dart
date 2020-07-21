import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters-screen';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  Widget _buildSwitchListTile(
      {@required String title,
      @required String subtTitle,
      @required var currentValue,
      @required Function handleValue}) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtTitle),
      onChanged: handleValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your meal Selection:',
                style: Theme.of(context).textTheme.headline6),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                    title: 'Gluten-free',
                    subtTitle: 'Only include gluten-free meals',
                    currentValue: _glutenFree,
                    handleValue: (newValue) {
                      setState(() => _glutenFree = newValue);
                    }),
                _buildSwitchListTile(
                    title: 'Lactose-free',
                    subtTitle: 'Only include lactose-free meals',
                    currentValue: _lactoseFree,
                    handleValue: (newValue) {
                      setState(() => _lactoseFree = newValue);
                    }),
                _buildSwitchListTile(
                    title: 'Vegetarian',
                    subtTitle: 'Only include vegetarian meals',
                    currentValue: _vegetarian,
                    handleValue: (newValue) {
                      setState(() => _vegetarian = newValue);
                    }),
                _buildSwitchListTile(
                    title: 'Vegan',
                    subtTitle: 'Only include vegan meals',
                    currentValue: _vegan,
                    handleValue: (newValue) {
                      setState(() => _vegan = newValue);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
