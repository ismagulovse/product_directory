import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final double min;
  final double max;
  final double limit;
  final ValueChanged<RangeValues> onChanged;

  const ProductPrice({
    super.key,
    required this.min,
    required this.max,
    required this.limit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Цена: от ${min.toStringAsFixed(2)} до ${max.toStringAsFixed(2)}',
          ),
          RangeSlider(
            min: 0,
            max: limit,
            values: RangeValues(min, max),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
