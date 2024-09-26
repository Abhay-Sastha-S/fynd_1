import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fynd_1/components/navbar.dart';

// Assume you have a list of products with image URLs
List<Product> products = [
  Product(id: 1, imageUrl: 'http://assets.myntassets.com/v1/assets/images/7098789/2018/8/20/dad722b8-f2c0-4e7e-aa5f-a3814856f8581534741627049-Libas-Women-Blue--White-Striped-Pathani-Kurta-6431534741626884-1.jpg'),
  Product(id: 2, imageUrl: 'http://assets.myntassets.com/v1/assets/images/productimage/2019/5/14/62087d45-2ad4-4676-901c-093d89a48ba51557797380449-1.jpg'),
  Product(id: 3, imageUrl: 'http://assets.myntassets.com/v1/assets/images/1923426/2017/6/21/11498040802877-The-Indian-Garage-Co-Men-Blue--White-Printed-A-Line-Kurta-7691498040798521-1.jpg'),
  Product(id: 4, imageUrl: 'http://assets.myntassets.com/v1/assets/images/9088553/2019/3/28/e355672e-a2a8-46ff-a72d-142b49a7532e1553773498920-Libas-Women-Dresses-991553773497864-1.jpg'),
  Product(id: 5, imageUrl: 'http://assets.myntassets.com/v1/assets/images/7766518/2018/11/12/04ad2286-2977-48f4-9d47-df1fe73a84731542012680275-Geroo-Women-Green-cotton-hand-block-print-skirt-9351542012680161-2.jpg'),
  Product(id: 6, imageUrl: 'https://via.placeholder.com/300x500/0ff300'),
  Product(id: 7, imageUrl: 'https://via.placeholder.com/100x300/0ff300'),
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
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
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
