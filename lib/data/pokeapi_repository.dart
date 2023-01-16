import 'package:dio/dio.dart';
import 'package:pokedex/models/pokeapi_response.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_data.dart';

class PokeApiRepository {
  const PokeApiRepository(this._dio);

  final Dio _dio;

  Future<List<PokemonData>> loadingPokemonUrls({
    String url = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=100',
    List<PokemonData> data = const [],
  }) async {
    try {
      final response = await _dio.get(url);

      final boundaries = url.split('?')[1].split('&');
      final offset = int.parse(boundaries[0].split('=')[1]);
      final limit = int.parse(boundaries[1].split('=')[1]);

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

  Future<Pokemon> getPokemon(String url) async {
    final pokemonResponse = await _dio.get(url);

    final data = pokemonResponse.data;

    final speciesUrl = data['species']['url'];
    final speciesResponse = await _dio.get(speciesUrl);

    final characteristic = await _dio.get(
      'https://pokeapi.co/api/v2/characteristic/${data['id']}',
    );

    return Pokemon.fromJson(
      data,
      speciesResponse.data,
      characteristic.data['descriptions'][7]['description'],
    );
  }
}
