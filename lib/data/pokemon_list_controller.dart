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

    /// rango tomado de los últimos valores almacenados. es decir, la cuenta
    /// será de los próximos valores a recuperar.
    for (int idx = from; idx < to; idx += 1) {
      /// verifica si la información esta almacenada o deba ser recuperada.
      final updatedPokemon = await checkPokemonData(data[idx]);

      /// actualiza la información recuperada.
      data[idx] = updatedPokemon;

      /// hace la división entre el contador del progreso actual y el número
      /// fijo de objetos a recuperar: {25}.
      _progressController.sink.add(progressIdx / 25);

      /// va aumentando el contador para ir aumentando el progreso de
      /// información recuperada.
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
