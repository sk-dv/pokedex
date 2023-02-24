import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pokedex/data/pokedex_cache.dart';
import 'package:pokedex/data/pokedex_locator.dart';
import 'package:pokedex/models/pokeapi_response.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_data.dart';

class PokeApiRepository {
  const PokeApiRepository(this._dio);

  final Dio _dio;

  Future<File?> convertEndpointToFile(String name, String? path) async {
    if (path == null) return null;

    final response = await _dio.get(
      path,
      options: Options(responseType: ResponseType.bytes),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File(join(directory.path, '$name.png'));
    file.writeAsBytesSync(response.data);

    return file;
  }

  Future<List<PokemonData>> loadingPokemonUrls({
    String url = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=100',
    List<PokemonData> data = const [],
  }) async {
    try {
      final response = await _dio.get(url);

      /// obtiene los limites mediante la url
      final boundaries = url.split('?')[1].split('&');
      final offset = int.parse(boundaries[0].split('=')[1]);
      final limit = int.parse(boundaries[1].split('=')[1]);

      /// los limites se envían con la intención de actualizar los índices
      /// conforme se va iterando
      final api = PokeApiResponse.fromJson(offset, limit, response.data);

      if (api.next == null) return data;

      return await loadingPokemonUrls(
        url: api.next!,
        data: [...data, ...api.results],
      );
    } catch (e) {
      return [];
    }
  }

  Future<String> _getDescription(String id) async {
    try {
      final response = await _dio.get(
        'https://pokeapi.co/api/v2/characteristic/$id',
      );

      return response.data['descriptions'][7]['description'];
    } catch (e) {
      return '';
    }
  }

  Future<Pokemon> getPokemon(String url) async {
    final pokemonResponse = await _dio.get(url);

    final data = pokemonResponse.data;

    final speciesUrl = data['species']['url'];
    final speciesResponse = await _dio.get(speciesUrl);

    final path = data['sprites']['other']['official-artwork']['front_default'];

    final downloader = PokedexLocator.locator<ImageDownloader>();
    final file = await downloader.saveImage(data['name'], path);

    return Pokemon.fromJson(
      data,
      speciesResponse.data,
      await _getDescription(data['id'].toString()),
      file,
    );
  }
}
