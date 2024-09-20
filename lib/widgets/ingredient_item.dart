import 'package:flutter/material.dart';

class IngredientItem extends StatelessWidget {
  const IngredientItem({super.key, required this.ingredient});

  final String ingredient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        ingredient,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
        textAlign: TextAlign.center,
      ),
    );
  }
}
