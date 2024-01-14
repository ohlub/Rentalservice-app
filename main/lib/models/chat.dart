// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Chat {
  final String id;
  final String member1;
  final String member2;
  final List<String> message1;
  final List<String> message2;
  final List<String> sentAt1;
  final List<String> sentAt2;
  final String name;
  final List<String> images;
  final double price;
  final String option;
  final bool direct;
  final bool delivery;
  Chat({
    required this.id,
    required this.member1,
    required this.member2,
    required this.message1,
    required this.message2,
    required this.sentAt1,
    required this.sentAt2,
    required this.name,
    required this.images,
    required this.price,
    required this.option,
    required this.direct,
    required this.delivery,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'member1': member1,
      'member2': member2,
      'message1': message1,
      'message2': message2,
      'sentAt1': sentAt1,
      'sentAt2': sentAt2,
      'name': name,
      'images': images,
      'price': price,
      'option': option,
      'direct': direct,
      'delivery': delivery,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      member1: map['member1'] ?? '',
      member2: map['member2'] ?? '',
      message1: List<String>.from(map['message1']),
      message2: List<String>.from(map['message2']),
      sentAt1: List<String>.from(map['sentAt1']),
      sentAt2: List<String>.from(map['sentAt2']),
      name: map['name'] ?? '',
      images: List<String>.from(map['images']),
      price: map['price']?.toDouble() ?? 0.0,
      option: map['option'] ?? '',
      direct: map['direct'] ?? false,
      delivery: map['delivery'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source));

  Chat copyWith({
    String? id,
    String? member1,
    String? member2,
    List<String>? message1,
    List<String>? message2,
    List<String>? sentAt1,
    List<String>? sentAt2,
    String? name,
    List<String>? images,
    double? price,
    String? option,
    bool? direct,
    bool? delivery,
  }) {
    return Chat(
      id: id ?? this.id,
      member1: member1 ?? this.member1,
      member2: member2 ?? this.member2,
      message1: message1 ?? this.message1,
      message2: message2 ?? this.message2,
      sentAt1: sentAt1 ?? this.sentAt1,
      sentAt2: sentAt2 ?? this.sentAt2,
      name: name ?? this.name,
      images: images ?? this.images,
      price: price ?? this.price,
      option: option ?? this.option,
      direct: direct ?? this.direct,
      delivery: delivery ?? this.delivery,
    );
  }
}
