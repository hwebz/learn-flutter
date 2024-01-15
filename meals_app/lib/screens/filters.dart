import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Filters")),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      //   }
      // }),
      body: Column(
        children: [
          switchOption(context, "Gluten Free", "Only include gluten free meals",
              activeFilters[Filter.glutenFree]!, (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, isChecked);
          }),
          switchOption(
              context,
              "Lactose Free",
              "Only include lactose free meals",
              activeFilters[Filter.lactoseFree]!, (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactoseFree, isChecked);
          }),
          switchOption(context, "Vegetarian", "Only include vegetarian meals",
              activeFilters[Filter.vegetarian]!, (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegetarian, isChecked);
          }),
          switchOption(context, "Vegan", "Only include vegan meals",
              activeFilters[Filter.vegan]!, (isChecked) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, isChecked);
          }),
        ],
      ),
    );
  }

  Widget switchOption(BuildContext context, String title, String subtitle,
      bool value, void Function(bool isChecked) onChange) {
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
