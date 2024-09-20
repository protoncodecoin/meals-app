import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  Vegetarian,
  Vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.Vegetarian: false,
          Filter.Vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
        (ref) => FilterNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    if (activeFilter[Filter.Vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    if (activeFilter[Filter.Vegan]! && !meal.isVegan) {
      return false;
    }

    return true; // meals i wanna keep
  }).toList();
});
