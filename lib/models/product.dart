class Product {
  final String? id;
  final String name;
  final double price;
  final String category;
  final String? imageUrl;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? category,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
