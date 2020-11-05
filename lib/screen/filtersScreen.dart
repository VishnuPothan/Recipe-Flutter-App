import 'package:flutter/material.dart';
import '../widgets/mainDrawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currFilters;

  FiltersScreen(this.saveFilters, this.currFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currFilters['gluten'];
    _lactoseFree = widget.currFilters['lactose'];
    _vegan = widget.currFilters['vegan'];
    _vegetarian = widget.currFilters['vegetarian'];
    super.initState();
  }

  Widget _builtSwitchListTile(
      String title, String description, bool currValue, Function updateValue) {
    return SwitchListTile(
      value: currValue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final Map<String, bool> selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _builtSwitchListTile(
                  'Gluten Free',
                  'Only include gluten-free food',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _builtSwitchListTile(
                  'Lactose Free',
                  'Only include lactose-free food',
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _builtSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian food',
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                _builtSwitchListTile(
                  'Vegan',
                  'Only include vegan food',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
