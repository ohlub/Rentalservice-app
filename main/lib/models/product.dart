// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sharing_world2/models/rating.dart';

class Product {
  final String? id;
  final String name;
  final double price;
  final List<String> images;
  final int quantity;
  final String description;
  final String category;
  final String seller;
  final String type;
  final String region;
  final String option;
  final bool direct;
  final bool delivery;
  final List<Rating>? rating;
  final List<String> reviews;
  Product({
    this.id,
    required this.name,
    required this.images,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    required this.seller,
    required this.type,
    required this.region,
    required this.option,
    required this.direct,
    required this.delivery,
    this.rating,
    required this.reviews,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'images': images,
      'price': price,
      'quantity': quantity,
      'description': description,
      'category': category,
      'rating': rating,
      'seller': seller,
      'type': type,
      'region': region,
      'option': option,
      'direct': direct,
      'delivery': delivery,
      'reviews': reviews,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'],
      name: map['name'] ?? '',
      images: List<String>.from(map['images']),
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      seller: map['seller'] ?? '',
      type: map['type'] ?? '',
      region: map['region'] ?? '',
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
      option: map['option'] ?? '',
      direct: map['direct'] ?? false,
      delivery: map['delivery'] ?? false,
      reviews: List<String>.from(map['reviews']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
