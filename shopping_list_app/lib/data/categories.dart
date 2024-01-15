import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/category.dart';

const categories = {
  Categories.vegetables:
      Category('Vegetables', Color.fromARGB(255, 0, 255, 128)),
  Categories.fruits: Category('Fruits', Color.fromARGB(255, 255, 128, 0)),
  Categories.meat: Category('Meat', Color.fromARGB(255, 255, 0, 0)),
  Categories.dairy: Category('Dairy', Color.fromARGB(255, 255, 255, 0)),
  Categories.carbs: Category('Carbs', Color.fromARGB(255, 255, 0, 255)),
  Categories.sweets: Category('Sweets', Color.fromARGB(255, 0, 255, 255)),
  Categories.spicies: Category('Spicies', Color.fromARGB(255, 128, 0, 255)),
  Categories.convenience:
      Category('Convenience', Color.fromARGB(255, 0, 0, 255)),
  Categories.hygiene: Category('Hygiene', Color.fromARGB(255, 0, 255, 0)),
  Categories.other: Category('Other', Color.fromARGB(255, 128, 128, 128)),
};
