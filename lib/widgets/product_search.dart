import 'package:flutter/material.dart';

class ProductSearch extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const ProductSearch({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Поиск',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
