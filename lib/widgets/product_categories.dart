import 'package:flutter/material.dart';

import '../data/category_names.dart';

class ProductCategories extends StatelessWidget {
  final List<String> items;
  final String selected;
  final ValueChanged<String> onChanged;

  const ProductCategories({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('Все'),
            selected: selected.isEmpty,
            onSelected: (value) {
              onChanged('');
            },
          ),
          for (final name in items)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ChoiceChip(
                label: Text(categoryNames[name] ?? name),
                selected: selected == name,
                onSelected: (value) {
                  onChanged(name);
                },
              ),
            ),
        ],
      ),
    );
  }
}
