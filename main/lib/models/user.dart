// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String region;
  final String token;
  final List<dynamic> cart;
  final List<dynamic> order;
  final List<String> search;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.region,
    required this.token,
    required this.cart,
    required this.order,
    required this.search,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'region': region,
      'token': token,
      'cart': cart,
      'order': order,
      'search': search,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      region: map['region'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      order: List<Map<String, dynamic>>.from(
        map['order']?.map(
              (x) => Map<String, dynamic>.from(x),
        ),
      ),
      search: List<String>.from(map['search']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? region,
    String? token,
    List<dynamic>? cart,
    List<dynamic>? order,
    List<String>? search,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      region: region ?? this.region,
      token: token ?? this.token,
      cart: cart ?? this.cart,
      order: order ?? this.order,
      search: search ?? this.search,
    );
  }
}
