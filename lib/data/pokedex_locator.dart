import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:pokedex/data/pokeapi_repository.dart';
import 'package:pokedex/data/pokedex_cache.dart';
import 'image_downloader.dart';
import 'pokemon_list_controller.dart';

class PokedexLocator {
  static GetIt locator = GetIt.instance;

  static Future<void> setup() async {
    final cache = await PokedexCache.init;

    locator.registerFactory<PokedexCache>(() => cache);

    locator.registerFactory<PokemonListController>(
      () => PokemonListController(
        PokeApiRepository(Dio()),
        cache,
        StreamController<double>(),
      ),
    );

    locator.registerLazySingletonAsync<ImageDownloader>(
      () => ImageDownloader.setup(),
    );

    await locator.isReady<ImageDownloader>();
  }
}
