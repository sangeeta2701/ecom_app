// To parse this JSON data, do
//
//     final snekers = snekersFromJson(jsonString);

import 'dart:convert';

List<Snekers> snekersFromJson(String str) => List<Snekers>.from(json.decode(str).map((x) => Snekers.fromJson(x)));

// String snekersToJson(List<Snekers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Snekers {
    String id;
    String name;
    String category;
    List<String> imageUrl;
    String oldPrice;
    List<dynamic> sizes;
    String price;
    String description;
    String title;

    Snekers({
        required this.id,
        required this.name,
        required this.category,
        required this.imageUrl,
        required this.oldPrice,
        required this.sizes,
        required this.price,
        required this.description,
        required this.title,
    });

    factory Snekers.fromJson(Map<String, dynamic> json) => Snekers(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        oldPrice: json["oldPrice"],
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        price: json["price"],
        description: json["description"],
        title: json["title"],
    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "name": name,
    //     "category": category,
    //     "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
    //     "oldPrice": oldPrice,
    //     "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
    //     "price": price,
    //     "description": description,
    //     "title": title,
    // };
}

// class Size {
//     String size;
//     bool isSelected;

//     Size({
//         required this.size,
//         required this.isSelected,
//     });

//     factory Size.fromJson(Map<String, dynamic> json) => Size(
//         size: json["size"],
//         isSelected: json["isSelected"],
//     );

//     Map<String, dynamic> toJson() => {
//         "size": size,
//         "isSelected": isSelected,
//     };
// }
