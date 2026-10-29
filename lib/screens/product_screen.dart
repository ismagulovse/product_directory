import 'package:flutter/material.dart';

import '../state/product_state.dart';
import '../widgets/product_card.dart';
import '../widgets/product_categories.dart';
import '../widgets/product_search.dart';
import '../widgets/product_sort.dart';
import '../widgets/product_price.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductState state = ProductState();

  @override
  void initState() {
    super.initState();
    state.loadProducts();
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Справочник товаров')),
      body: SafeArea(
        child: Column(
          children: [
            ProductSearch(onChanged: state.search),
            Expanded(
              child: ListenableBuilder(
                listenable: state,
                builder: (context, child) {
                  return Column(
                    children: [
                      if (state.items.isNotEmpty)
                        Flexible(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ProductCategories(
                                  items: state.getCategories(),
                                  selected: state.category,
                                  onChanged: state.selectCategory,
                                ),
                                ProductSort(
                                  selected: state.order,
                                  onChanged: state.selectOrder,
                                ),
                                ProductPrice(
                                  min: state.minPrice,
                                  max: state.maxPrice,
                                  limit: state.priceLimit,
                                  onChanged: (value) {
                                    state.selectPrice(value.start, value.end);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      Expanded(child: buildBody()),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error.isNotEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.error, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: state.loadProducts,
                child: const Text('Повторить'),
              ),
            ],
          ),
        ),
      );
    }

    final items = state.getItems();

    if (items.isEmpty) {
      return const Center(child: Text('Товары не найдены'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ProductCard(item: items[index]);
      },
    );
  }
}
