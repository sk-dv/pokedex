import 'dart:async';

import 'package:pokedex/data/pokedex_cache.dart';
import 'package:pokedex/models/pokemon_data.dart';
import 'pokeapi_repository.dart';

class PokemonListController {
  final PokeApiRepository _repository;
  final PokedexCache _cache;
  final StreamController<double> _progressController;

  const PokemonListController(
    this._repository,
    this._cache,
    this._progressController,
  );

  Stream<double> get progress => _progressController.stream;

  Future<int> getListOffset() async {
    return _cache.getOffset();
  }

  Future<void> saveListOffset(int offset) async {
    await _cache.updateOffset(offset);
  }

  Future<List<PokemonData>> cacheChecking() async {
    final data = await _cache.readPokemonDataList();
    if (data.isNotEmpty) return data;

    final retrievedData = await _repository.loadingPokemonUrls();

    await _cache.writePokemonDataList(retrievedData);

    return retrievedData;
  }

  Future<List<PokemonData>> retrievePokemonData(
    List<PokemonData> data,
    int from,
    int to,
  ) async {
    int progressIdx = 1;

    for (int idx = from; idx < to; idx += 1) {
      final updatedPokemon = await checkPokemonData(data[idx]);
      data[idx] = updatedPokemon;

      _progressController.sink.add(progressIdx / 25);
      progressIdx += 1;
    }

    return data;
  }

  Future<PokemonData> checkPokemonData(PokemonData data) async {
    if (data.pokemon == null) {
      final pokemon = await _repository.getPokemon(data.pokemonUrl.url);
      return await _cache.updatePokemonData(data.copy(pokemon: pokemon));
    } else {
      return await _cache.getPokemonData(data.id);
    }
  }

  Future<PokemonData> markAsFavorite(PokemonData data) {
    return _cache.updatePokemonData(data);
  }
}
