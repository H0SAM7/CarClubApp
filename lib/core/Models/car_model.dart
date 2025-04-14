import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'car_model.g.dart';

@HiveType(typeId: 0)
class CarModel extends HiveObject {
  @HiveField(0)
  final String code;
  @HiveField(1)
  final String brand;

  @HiveField(2)
  final String name;
  @HiveField(3)
  final String color;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final int price;

  @HiveField(6)
  final String image;

  CarModel({
    required this.code,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.brand,
    required this.color,
  });
  // Convert Firestore document to CarModel
  factory CarModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CarModel(
      code: data['code'],
      brand: data['brand'],
      name: data['name'],
      description: data['description'],
      price: data['price'],
      color: data['color'],
      image: data['imageUrl'],
    );
  }
  factory CarModel.fromMap(Map<String, dynamic> data) {
    return CarModel(
      code: data['code'],
      price: data['price'],
      color: data['color'],
      brand: data['brand'],
      name: data['name'],
      description: data['description'],
      image: data['imageUrl'],
    );
  }

  // Convert CarModel to map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,

      'color': color,
      'price': price,
      'code': code,
      'description': description,
      'imageUrl': image,
    };
  }
}
