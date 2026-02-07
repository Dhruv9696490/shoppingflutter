class StoreData {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;
  bool isFavorite;
  StoreData({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.isFavorite = false
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rate': rating?.rate ?? 0.0,
      'count': rating?.count ?? 0,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
factory StoreData.fromMap(Map<String, dynamic> map){//
    return StoreData(
      id: map["id"],
      title: map["title"],
      price: map["price"],
      description: map["description"],
      category: map["category"],
      image: map["image"],
      rating: Rating(rate: map['rate'], count: map['count']),
    );
  }

  factory StoreData.fromJson(Map<String, dynamic> json){//
    return StoreData(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      category: json["category"],
      image: json["image"],
      rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
    );
  }
}

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  final double? rate;
  final int? count;

  factory Rating.fromJson(Map<String, dynamic> json){
    return Rating(
      rate: (json["rate"] as num).toDouble(),
      count: json["count"],
    );
  }

}

