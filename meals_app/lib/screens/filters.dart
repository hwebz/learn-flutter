import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
    _veganFilterSet = activeFilters[Filter.vegan]!;
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
          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });

          return true;
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
