class Product {
  final int id;
  final String name;
  final String text;
  final double price;
  final String category;
  final double rating;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.text,
    required this.price,
    required this.category,
    required this.rating,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'],
      text: json['description'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      rating: (json['rating'] as num).toDouble(),
      image: json['thumbnail'],
    );
  }
}
