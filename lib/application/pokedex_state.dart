part of 'pokedex_cubit.dart';

class PokedexState {
  const PokedexState({
    required this.pokemonData,
    required this.listOffset,
    required this.found,
    required this.progress,
  });

  final List<PokemonData> pokemonData;
  final int listOffset;
  final List<PokemonData> found;
  final double progress;

  static const PokedexState empty = PokedexState(
    pokemonData: [],
    listOffset: 0,
    found: [],
    progress: 0.0,
  );

  List<PokemonData> get validData {
    return pokemonData.where((data) => data.pokemon != null).toList();
  }

  List<PokemonData> get favorites {
    return pokemonData.where((data) => data.isFavorite).toList();
  }

  PokedexState copy({
    List<PokemonData>? pokemonData,
    int? listOffset,
    List<PokemonData>? found,
    double? progress,
  }) {
    return PokedexState(
      pokemonData: pokemonData ?? this.pokemonData,
      listOffset: listOffset ?? this.listOffset,
      found: found ?? this.found,
      progress: progress ?? this.progress,
    );
  }
}
