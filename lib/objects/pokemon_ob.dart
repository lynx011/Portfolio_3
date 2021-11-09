
// To parse this JSON data, do
//
//     final pokemonOb = pokemonObFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PokemonOb {
  PokemonOb({
    required this.num,
    required this.name,
    required this.variations,
    required this.link,
  });

  int num;
  String name;
  List<Variation> variations;
  String link;

  factory PokemonOb.fromJson(String str) => PokemonOb.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonOb.fromMap(Map<String, dynamic> json) => PokemonOb(
    num: json["num"],
    name: json["name"].toString(),
    variations: List<Variation>.from(json["variations"].map((x) => Variation.fromMap(x))),
    link: json["link"].toString(),
  );

  Map<String, dynamic> toMap() => {
    "num": num,
    "name": name,
    "variations": List<dynamic>.from(variations.map((x) => x.toMap())),
    "link": link,
  };
}

class Variation {
  Variation({
    required this.name,
    required this.description,
    required this.image,
    required this.types,
    required this.specie,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.stats,
    required this.evolutions,
  });

  String name;
  String description;
  String image;
  List<String> types;
  String specie;
  num height;
  num weight;
  List<String> abilities;
  Stats stats;
  List<String> evolutions;

  factory Variation.fromJson(String str) => Variation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Variation.fromMap(Map<String, dynamic> json) => Variation(
    name: json["name"].toString(),
    description: json["description"].toString(),
    image: json["image"].toString(),
    types: List<String>.from(json["types"].map((x) => x)),
    specie: json["specie"].toString(),
    height: json["height"],
    weight: json["weight"],
    abilities: List<String>.from(json["abilities"].map((x) => x)),
    stats: Stats.fromMap(json["stats"]),
    evolutions: List<String>.from(json["evolutions"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "description": description,
    "image": image,
    "types": List<dynamic>.from(types.map((x) => x)),
    "specie": specie,
    "height": height,
    "weight": weight,
    "abilities": List<dynamic>.from(abilities.map((x) => x)),
    "stats": stats.toMap(),
    "evolutions": List<dynamic>.from(evolutions.map((x) => x)),
  };
}

class Stats {
  Stats({
    required this.total,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speedAttack,
    required this.speedDefense,
    required this.speed,
  });

  num total;
  num hp;
  num attack;
  num defense;
  num speedAttack;
  num speedDefense;
  num speed;

  factory Stats.fromJson(String str) => Stats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stats.fromMap(Map<String, dynamic> json) => Stats(
    total: json["total"],
    hp: json["hp"],
    attack: json["attack"],
    defense: json["defense"],
    speedAttack: json["speedAttack"],
    speedDefense: json["speedDefense"],
    speed: json["speed"],
  );

  Map<String, dynamic> toMap() => {
    "total": total,
    "hp": hp,
    "attack": attack,
    "defense": defense,
    "speedAttack": speedAttack,
    "speedDefense": speedDefense,
    "speed": speed,
  };
}
