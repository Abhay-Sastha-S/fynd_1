import 'package:flutter/material.dart';

class Product {
  final List<String> images;
  final String name;
  final String description;
  final double price;

  Product({
    required this.images,
    required this.name,
    required this.description,
    required this.price,
  });
}

class DataProvider extends ChangeNotifier {
  List<Product> _products = [
    Product(
      images: [
        'http://assets.myntassets.com/v1/assets/images/productimage/2019/7/18/0697bc97-9cdc-4081-abf4-f448eaf7db331563453095388-1.jpg',
        'http://assets.myntassets.com/v1/assets/images/productimage/2019/7/18/90ba62b4-cc0c-4de4-be48-f8ac497e479a1563453095410-2.jpg',
        'http://assets.myntassets.com/v1/assets/images/productimage/2019/7/18/5edb2c02-4164-4c20-b848-76a35e1aa58f1563453095437-3.jpg',
      ],
      name: 'Fashion Product 1',
      description: 'Description of fashion product 1. This product is amazing and stylish.',
      price: 49.99,
    ),
    Product(
      images: [
        'http://assets.myntassets.com/v1/assets/images/7432155/2018/9/19/1fb2f966-63c5-4cb1-a78d-12ab44faf1e21537337352049-Manyavar-Mens-Sea-Green-Full-Sleeve-Regular-Fit-Self-Designed-Kurta--Churidar-Set-6331537337351850-1.jpg',
        'http://assets.myntassets.com/v1/assets/images/7432155/2018/9/19/0da16fcd-a5af-404c-8874-5a32b33a5a8a1537337352026-Manyavar-Mens-Sea-Green-Full-Sleeve-Regular-Fit-Self-Designed-Kurta--Churidar-Set-6331537337351850-2.jpg',
        'http://assets.myntassets.com/v1/assets/images/7432155/2018/9/19/a9e9ba0a-bec6-44b1-898f-7a686608e07f1537337351988-Manyavar-Mens-Sea-Green-Full-Sleeve-Regular-Fit-Self-Designed-Kurta--Churidar-Set-6331537337351850-3.jpg',
      ],
      name: 'Fashion Product 2',
      description: 'Description of fashion product 2. Perfect for any occasion.',
      price: 59.99,
    ),
    Product(
      images: [
        'http://assets.myntassets.com/v1/assets/images/7441182/2018/11/10/f5427679-c669-42b7-86a1-9aec1d1837f81541830165438-House-of-Pataudi-Men-Black-Printed-Straight-Kurta-3381541830-4.jpg',
        'http://assets.myntassets.com/v1/assets/images/7441182/2018/11/10/d859a4ad-46e8-4a00-8fb0-581ad42371ff1541830165454-House-of-Pataudi-Men-Black-Printed-Straight-Kurta-3381541830-3.jpg',
        'http://assets.myntassets.com/v1/assets/images/7441182/2018/11/10/28c93a4d-ff32-4418-a213-d6c8d8ce4a761541830165474-House-of-Pataudi-Men-Black-Printed-Straight-Kurta-3381541830-2.jpg',
      ],
      name: 'Fashion Product 3',
      description: 'Description of fashion product 2. Perfect for any occasion.',
      price: 39.99,
    ),
    Product(
      images: [
        'http://assets.myntassets.com/v1/assets/images/8991019/2019/4/9/0da32239-9a9a-4179-bbcc-5deba07664f91554807963228-612-league-Boys-Red--Beige-Solid-Kurta-with-Churidar-7901554-1.jpg',
        'http://assets.myntassets.com/v1/assets/images/8991019/2019/4/9/d98a1a45-dd9d-4d33-8b50-10c48bf05b171554807963154-612-league-Boys-Red--Beige-Solid-Kurta-with-Churidar-7901554-4.jpg',
        'http://assets.myntassets.com/v1/assets/images/8991019/2019/4/9/952ebee9-5cb2-463f-b010-9d5e6392dac11554807963109-612-league-Boys-Red--Beige-Solid-Kurta-with-Churidar-7901554-6.jpg',
      ],
      name: 'Fashion Product 4',
      description: 'Description of fashion product 2. Perfect for any occasion.',
      price: 19.99,
    ),
    // Add more products as needed
  ];

  List<Product> get products => _products;

  // Filter state
  Map<String, Set<String>> _selectedFilters = {
    'Brand': {},
    'Color': {},
    'Size': {},
    'Price Range': {},
    'Material': {},
    'Type': {},
  };

  Map<String, Set<String>> get selectedFilters => _selectedFilters;

  void toggleFilter(String category, String value) {
    if (_selectedFilters[category]?.contains(value) ?? false) {
      _selectedFilters[category]?.remove(value);
    } else {
      _selectedFilters[category]?.add(value);
    }
    notifyListeners();
  }

  void onCardSwiped(int index, direction) {
    // Collaborative filtering logic to update product recommendations
    _products.shuffle();
    notifyListeners();
  }
}
