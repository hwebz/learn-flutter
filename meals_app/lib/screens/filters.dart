import 'package:flutter/material.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/main_drawer.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Filters")),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      //   }
      // }),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });

          return false;
        },
        child: Column(
          children: [
            switchOption("Gluten Free", "Only include gluten free meals",
                _glutenFreeFilterSet, (isChecked) {
              setState(() {
                _glutenFreeFilterSet = isChecked;
              });
            }),
            switchOption("Lactose Free", "Only include lactose free meals",
                _lactoseFreeFilterSet, (isChecked) {
              setState(() {
                _lactoseFreeFilterSet = isChecked;
              });
            }),
            switchOption("Vegetarian", "Only include vegetarian meals",
                _vegetarianFilterSet, (isChecked) {
              setState(() {
                _vegetarianFilterSet = isChecked;
              });
            }),
            switchOption("Vegan", "Only include vegan meals", _veganFilterSet,
                (isChecked) {
              setState(() {
                _veganFilterSet = isChecked;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget switchOption(String title, String subtitle, bool value,
      void Function(bool isChecked) onChange) {
    return SwitchListTile(
      value: value,
      onChanged: onChange,
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground)),
      subtitle: Text(subtitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground)),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
