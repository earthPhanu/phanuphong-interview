class Campaigns {
  String? name = null;
  String? price = null;
  String? imageUrl = null;
  String? description = null;

  Campaigns({this.name, this.price, this.imageUrl, this.description});

  Campaigns.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    imageUrl = json['image_url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['image_url'] = this.imageUrl;
    data['description'] = this.description;
    return data;
  }
}