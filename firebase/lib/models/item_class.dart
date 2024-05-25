class Item {
  late int id;
  late String title;
  late String price;
  late String description;
  late String category;
  late String image;
  late double rating;
  late int ratingCount;
  late int quantity;

  Item({
    this.id = 0,
    required this.title,
    this.price = '',
    this.description = '',
    required this.category,
    required this.image,
    this.rating = 2,
    this.ratingCount = 120,
    this.quantity = 1,
  });

  /*Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'].toString();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] ?? 3.9;
    ratingCount = json['ratingCount'] ?? 120;
    quantity = 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    return data;
  }*/
}
