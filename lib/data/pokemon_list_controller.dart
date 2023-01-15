import 'package:pokedex/data/pokedex_cache.dart';
import 'package:pokedex/models/pokemon_data.dart';

import 'pokeapi_repository.dart';

class PokemonListController {
  final PokeApiRepository _repository;
  final PokedexCache _cache;

  const PokemonListController(this._repository, this._cache);

  Future<List<PokemonData>> cacheChecking() async {
    final data = await _cache.readPokemonDataList();
    if (data.isNotEmpty) return data;

    final retrievedData = await _repository.loadingPokemonUrls();
    await _cache.writePokemonDataList(retrievedData);

    return retrievedData;
  }

  Future<List<PokemonData>> retrievePokemonData(List<PokemonData> data,
      [int from = 0, int to = 25]) async {
    for (int idx = from; idx < to; idx += 1) {
      final updatedPokemon = await _checkPokemonData(data[idx]);
      data[idx] = updatedPokemon;
    }

    return data;
  }

  Future<PokemonData> _checkPokemonData(PokemonData data) async {
    if (data.pokemon == null) {
      final pokemon = await _repository.getPokemon(data.pokemonUrl.url);
      return await _cache.updatePokemonData(data.id, pokemon);
    } else {
      return await _cache.getPokemonData(data.id);
    }
  }
}
