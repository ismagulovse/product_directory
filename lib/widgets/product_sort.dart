import 'package:flutter/material.dart';

class ProductSort extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const ProductSort({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        value: selected,
        isExpanded: true,
        items: const [
          DropdownMenuItem(value: 'none', child: Text('Без сортировки')),
          DropdownMenuItem(value: 'asc', child: Text('Сначала дешёвые')),
          DropdownMenuItem(value: 'desc', child: Text('Сначала дорогие')),
        ],
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }
}
