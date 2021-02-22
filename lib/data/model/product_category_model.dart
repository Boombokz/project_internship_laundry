class ProductCategory {
  String uuid;
  String name;
  String picture;
  String description;

  ProductCategory({
    this.uuid,
    this.name,
    this.picture,
    this.description,
  });

  ProductCategory.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    picture = json['picture'];
    description = json['description'];
  }
}
