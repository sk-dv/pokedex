import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/data/pokeapi_repository.dart';
import 'package:pokedex/data/pokedex_cache.dart';

import 'pokemon_list_controller.dart';

class PokedexLocator {
  static GetIt locator = GetIt.instance;

  static Future<void> setup() async {
    const String pokemonKey = 'Pokedex:PokemonUrl:Box';
    final cache = await PokedexCache.init(pokemonKey);

    locator.registerFactory<PokemonListController>(
        () => PokemonListController(PokeApiRepository(Dio()), cache));
  }
}
