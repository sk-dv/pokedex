import 'package:pokedex/data/pokedex_cache.dart';
import 'package:pokedex/data/pokedex_locator.dart';
import 'package:pokedex/models/pokemon_url.dart';

import 'pokeapi_repository.dart';

class PokemonListController {
  final PokeApiRepository _repository;
  final PokedexCache _cache;

  const PokemonListController(this._repository, this._cache);

  Future<List<PokemonUrl>> cacheChecking() async {
    final urls = await _cache.readList<PokemonUrl>();
    if (urls.isNotEmpty) return urls;

    return _repository.loadingPokemonUrls();
  }
}
