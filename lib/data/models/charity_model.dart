// To parse this JSON data, do
//
//     final charity = charityFromJson(jsonString);

import 'dart:convert';

Charity? charityFromJson(String str) => Charity.fromJson(json.decode(str));

String charityToJson(Charity? data) => json.encode(data!.toJson());

class Charity {
    Charity({
        required this.id,
        required this.name,
        required this.goals,
        required this.raised,
        required this.image,
    });

    int id;
    String name;
    int goals;
    int raised;
    String image;

    Charity copyWith({
        int? id,
        String? name,
        int? goals,
        int? raised,
        String? image,
    }) => 
        Charity(
            id: id ?? this.id,
            name: name ?? this.name,
            goals: goals ?? this.goals,
            raised: raised ?? this.raised,
            image: image ?? this.image,
        );

    factory Charity.fromJson(Map<String, dynamic> json) => Charity(
        id: json["id"],
        name: json["name"],
        goals: json["goals"],
        raised: json["raised"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "goals": goals,
        "raised": raised,
        "image": image,
    };
}
