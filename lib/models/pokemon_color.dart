import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'pokemon_color.g.dart';

@HiveType(typeId: 4)
enum PokemonColor {
  @HiveField(0)
  black,
  @HiveField(1)
  blue,
  @HiveField(2)
  brown,
  @HiveField(3)
  gray,
  @HiveField(4)
  green,
  @HiveField(5)
  pink,
  @HiveField(6)
  purple,
  @HiveField(7)
  red,
  @HiveField(8)
  white,
  @HiveField(9)
  yellow,
  @HiveField(10)
  none;

  Color get color {
    switch (this) {
      case black:
        return Colors.black;
      case blue:
        return Colors.blue;
      case brown:
        return Colors.brown;
      case gray:
        return Colors.grey;
      case green:
        return Colors.green;
      case pink:
        return Colors.pink;
      case purple:
        return Colors.purple;
      case red:
        return Colors.red;
      case white:
        return Colors.white;
      case yellow:
        return Colors.yellow;
      default:
        return Colors.transparent;
    }
  }

  factory PokemonColor.fromString(String color) {
    switch (color) {
      case 'black':
        return PokemonColor.black;
      case 'blue':
        return PokemonColor.blue;
      case 'brown':
        return PokemonColor.brown;
      case 'gray':
        return PokemonColor.gray;
      case 'green':
        return PokemonColor.green;
      case 'pink':
        return PokemonColor.pink;
      case 'purple':
        return PokemonColor.purple;
      case 'red':
        return PokemonColor.red;
      case 'white':
        return PokemonColor.white;
      case 'yellow':
        return PokemonColor.yellow;
      default:
        return PokemonColor.none;
    }
  }
}
