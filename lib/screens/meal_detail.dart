import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/ingredient_item.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/provider/favorites_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen(
      {super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? "Meal added as favorite"
                      : "Meal removed from favorites hgh."),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                    turns:
                        Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                    child: child);
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Hero(
            tag: meal.id,
            child: Image.network(meal.imageUrl,
                height: 300, width: double.infinity, fit: BoxFit.cover),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  Text(
                    "Ingredients",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(height: 10),
                  for (final ingredient in meal.ingredients)
                    IngredientItem(ingredient: ingredient),
                  const SizedBox(height: 30),
                  Text(
                    "Steps",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  for (final step in meal.steps)
                    IngredientItem(ingredient: step)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
