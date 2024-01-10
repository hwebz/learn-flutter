import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
          onTap: () {
            onSelectMeal(meal);
          },
          child: Stack(
            children: [
              FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      color: Colors.black54,
                      child: Column(
                        children: [
                          Text(
                            meal.title,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MealItemTrait(
                                  icon: Icons.schedule,
                                  label: '${meal.duration} min'),
                              const SizedBox(width: 12),
                              MealItemTrait(
                                  icon: Icons.work, label: complexityText),
                              const SizedBox(width: 12),
                              MealItemTrait(
                                  icon: Icons.attach_money,
                                  label: affordabilityText)
                            ],
                          )
                        ],
                      ))),
            ],
          )),
    );
  }
}
