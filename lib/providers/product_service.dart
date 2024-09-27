import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class Product {
  final String ideally;
  final List<String> images;
  final String name;
  final String description;
  final double price;
  final String brand;

  Product({
    required this.images,
    required this.ideally,
    required this.name,
    required this.description,
    required this.price,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      images: List<String>.from(json['images'].split(' | ')),
      ideally: json['ideal_for'],
      name: json['title'],
      description: json['body'],
      price: json['variant_price'].toDouble(),
      brand: json['brand'],
    );
  }

  Map<String, dynamic> toJson() => {
    'images': images.join(' | '),
    'ideal_for': ideally,
    'title': name,
    'body': description,
    'variant_price': price,
    'brand': brand,
  };
}

class ProductService {
  static const String _baseUrl = 'http://192.168.230.161:5000';
  static const String _productsEndpoint = '/print_products';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ProductAdapter()); // Make sure you register once with a unique typeId
    }
    await Hive.openBox<Product>('products');
  }

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl$_productsEndpoint'));

    if (response.statusCode == 200) {
      List<dynamic> productsJson = json.decode(response.body);
      List<Product> products = productsJson.map((json) => Product.fromJson(json)).toList();
      
      // Store products in Hive
      final box = Hive.box<Product>('products');
      await box.clear();
      await box.addAll(products);

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static List<Product> getProductsFromHive() {
    final box = Hive.box<Product>('products');
    return box.values.toList();
  }

  static List<Product> getPreloadedProducts() {
    final box = Hive.box<Product>('products');
    return box.values.take(3).toList();
  }
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final typeId = 1; // Changed to a unique typeId

  @override
  Product read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      images: (fields[0] as String).split(' | '),
      ideally: fields[1] as String,
      name: fields[2] as String,
      description: fields[3] as String,
      price: fields[4] as double,
      brand: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.images.join(' | '))
      ..writeByte(1)
      ..write(obj.ideally)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.brand);
  }
}
