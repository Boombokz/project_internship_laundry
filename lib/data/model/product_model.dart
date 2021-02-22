import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String category;
  @HiveField(2)
  String name;
  @HiveField(3)
  String picture;
  @HiveField(4)
  double price;
  @HiveField(5)
  double duration;
  @HiveField(6)
  String hintTitle;
  @HiveField(7)
  String hintDescription;
  @HiveField(8)
  int count = 0;

  Product(
      {this.id,
      this.category,
      this.name,
      this.picture,
      this.price,
      this.duration,
      this.hintTitle,
      this.hintDescription});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['uuid'] as String,
      category: json['category'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String,
      price: json['price'] as double,
      duration: json['duration'] as double,
      hintDescription: json['hint']['description'] as String,
      hintTitle: json['hint']['title'] as String,
    );
  }
}
