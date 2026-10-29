import 'package:flutter/material.dart';

import '../data/category_names.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product item;

  const ProductDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final category = categoryNames[item.category] ?? item.category;

    return Scaffold(
      appBar: AppBar(title: const Text('О товаре')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Image.network(
              item.image,
              height: 240,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) {
                return const SizedBox(
                  height: 240,
                  child: Icon(Icons.image_not_supported_outlined, size: 64),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(item.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text('Цена: ${item.price.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('Рейтинг: ${item.rating}'),
            const SizedBox(height: 8),
            Text('Категория: $category'),
            const SizedBox(height: 20),
            Text('Описание', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(item.text),
          ],
        ),
      ),
    );
  }
}
