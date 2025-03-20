import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mid_term/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'VND',
      decimalDigits: 0,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  product.imageUrl != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                        ),
                      )
                      : const Icon(Icons.image, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Giá: ${currencyFormat.format(product.price)}',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Category: ${product.category}',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
