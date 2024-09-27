import 'package:flutter/material.dart';
import '../providers/product_service.dart';

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
    } else if (verticalOffsetPercentage < -35) {
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
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height - 135, // Adjust as needed
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              product.images[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height - 135,
                            padding: EdgeInsets.fromLTRB(10, 12, 10, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                      colors: [
                                  Colors.black.withOpacity(0.16),
                                  Colors.transparent,
                                ],
                                stops: [0.001, 1.5],
                                //transform: GradientTransform(),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height-235),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Text(
                                    product.brand,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 2),
                                  child: Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      //fontWeight: FontWeight.bold,
                                    ),
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
              left: 4, right: 4, top:4, bottom : 4,
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