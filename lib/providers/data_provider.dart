import 'package:flutter/material.dart';
import 'product_service.dart';

class DataProvider extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = true;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  // Filter state
  Map<String, Set<String>> _selectedFilters = {
    'for':{},
    'Brand': {},
    'Color': {},
    'Size': {},
    'Price Range': {},
    'Material': {},
    'Type': {},
  };

  Map<String, Set<String>> get selectedFilters => _selectedFilters;

  Future<void> loadProducts() async {
  _isLoading = true;
  notifyListeners();

  try {
    await ProductService.fetchProducts();
    _products = ProductService.getProductsFromHive();
  } catch (e) {
    print('Error loading products: $e');
  }

  _isLoading = false;
  notifyListeners();
}

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