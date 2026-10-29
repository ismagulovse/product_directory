import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product item;

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProductDetailScreen(item: item);
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Image.network(
                item.image,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stack) {
                  return const SizedBox(
                    width: 80,
                    height: 80,
                    child: Icon(Icons.image_not_supported_outlined),
                  );
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Цена: ${item.price.toStringAsFixed(2)}'),
                    const SizedBox(height: 4),
                    Text('Рейтинг: ${item.rating}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
