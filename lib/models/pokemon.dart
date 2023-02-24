import 'package:hive/hive.dart';

import 'package:pokedex/models/pokemon_color.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 3)
class Pokemon {
  const Pokemon(
    this.id,
    this._name,
    this.types,
    this.image,
    this._color,
    this.genera,
    this.description,
  );

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String _name;

  @HiveField(2)
  final List<String> types;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String _color;

  @HiveField(5)
  final String genera;

  @HiveField(6)
  final String description;

  factory Pokemon.fromJson(
    Map<String, dynamic> pokemonJson,
    Map<String, dynamic> speciesJson,
    String description,
    String? filePath,
  ) {
    final rawTypes = pokemonJson['types'] as List;
    final types = rawTypes.map<String>((t) => t['type']['name']).toList();

    final genera = speciesJson['genera'];

    return Pokemon(
      pokemonJson['id'],
      pokemonJson['name'],
      types,
      filePath,
      speciesJson['color']['name'],
      (genera as List).isEmpty ? '' : genera[7]['genus'],
      description,
    );
  }

  PokemonColor get pokemonColor => PokemonColor.fromString(_color);

  String get name =>
      _name.substring(0, 1).toUpperCase() + _name.substring(1, _name.length);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'types': types, 'image': image};
  }
}
