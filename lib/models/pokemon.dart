import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/models/pokemon_color.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 3)
class Pokemon {
  const Pokemon(this.id, this._name, this.types, this.image, this._color);

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String _name;

  @HiveField(2)
  final List<String> types;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String _color;

  factory Pokemon.fromJson(
      Map<String, dynamic> pokemonJson, Map<String, dynamic> speciesJson) {
    final rawTypes = pokemonJson['types'] as List;
    final types = rawTypes.map<String>((t) => t['type']['name']).toList();

    final image =
        pokemonJson['sprites']['other']['official-artwork']['front_default'];

    final color = speciesJson['color']['name'];

    return Pokemon(pokemonJson['id'], pokemonJson['name'], types, image, color);
  }

  Color get color => PokemonColor.fromString(_color).color;

  String get name =>
      _name.substring(0, 1).toUpperCase() + _name.substring(1, _name.length);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'types': types, 'image': image};
  }
}
