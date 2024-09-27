import 'package:flutter/material.dart';
import 'package:fynd_1/providers/data_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ScrollController scrollController;
  final int horizontalOffsetPercentage;
  final int verticalOffsetPercentage;

  ProductCard({
    required this.product,
    required this.scrollController,
    this.horizontalOffsetPercentage = 0,
    this.verticalOffsetPercentage = 0,
  });

  @override
  Widget build(BuildContext context) {
    Icon? overlayIcon;
    if (horizontalOffsetPercentage > 35) {
      overlayIcon = Icon(Icons.favorite, size: 200, color: Colors.white.withOpacity(1));
    } else if (horizontalOffsetPercentage < -35) {
      overlayIcon = Icon(Icons.close, size: 200, color: Colors.white.withOpacity(1));
    } else if (verticalOffsetPercentage < 0) {
      overlayIcon = Icon(Icons.shopping_cart, size: 200, color: Colors.white.withOpacity(1));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            shadowColor: Colors.grey,
            elevation: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // First image as full-screen slide with name and price overlay
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height - 135, // Adjust as needed
                          child: Image.network(
                            product.images[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 80,
                            padding: EdgeInsets.fromLTRB(10, 12, 10, 5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                                //transform: GradientTransform(),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Product details
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            product.description,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'More Images',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          // Additional images
                          for (int i = 1; i < product.images.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Image.network(
                                product.images[i],
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (overlayIcon != null)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: overlayIcon),
              ),
            ),
        ],
      ),
    );
  }
}