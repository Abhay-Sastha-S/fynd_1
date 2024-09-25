import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fynd_1/components/navbar.dart';

// Assume you have a list of products with image URLs
List<Product> products = [
  Product(id: 1, imageUrl: 'https://via.placeholder.com/300x400/0ff23f'),
  Product(id: 2, imageUrl: 'https://via.placeholder.com/500x400/0ff300'),
  Product(id: 3, imageUrl: 'https://via.placeholder.com/200x200/0ff000'),
  Product(id: 4, imageUrl: 'https://via.placeholder.com/300x600/0ff300'),
  // Add more products...
];

class Product {
  final int id;
  final String imageUrl;

  Product({required this.id, required this.imageUrl});
}

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.builder(
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductImage(product: products[index]);
          },
        ),
      ),
      bottomNavigationBar:BottomNavigation() ,
    );
  }
}

class ProductImage extends StatelessWidget {
  final Product product;

  ProductImage({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details page when image is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover, // Ensure the image fits the container
        ),
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Center(
        child: Text('Product ${product.id} details'),
      ),
    );
  }
}
