import 'package:hive/hive.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_url.dart';

part 'pokemon_data.g.dart';

@HiveType(typeId: 1)
class PokemonData {
  const PokemonData({
    required this.id,
    required this.pokemonUrl,
    required this.pokemon,
    required this.isFavorite,
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  final PokemonUrl pokemonUrl;

  @HiveField(2)
  final Pokemon? pokemon;

  @HiveField(3)
  final bool isFavorite;

  factory PokemonData.fromJson(int index, Map<String, dynamic> json) {
    return PokemonData(
      id: index,
      pokemonUrl: PokemonUrl.fromJson(json),
      pokemon: null,
      isFavorite: false,
    );
  }

  PokemonData copy({Pokemon? pokemon, bool? isFavorite}) {
    return PokemonData(
      id: id,
      pokemonUrl: pokemonUrl,
      pokemon: pokemon ?? this.pokemon,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
