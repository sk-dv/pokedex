import 'package:dio/dio.dart';

import '../models/pokeapi_response.dart';
import '../models/pokemon_url.dart';

class PokeApiRepository {
  const PokeApiRepository(this._dio);

  final Dio _dio;

  Future<List<PokemonUrl>> loadingPokemonUrls({
    String url = 'https://pokeapi.co/api/v2/pokemon/?limit=100&offset=0',
    List<PokemonUrl> urls = const [],
  }) async {
    try {
      final response = await _dio.get(url);
      final api = PokeApiResponse.fromJson(response.data);

      if (api.next == null) return urls;

      return await loadingPokemonUrls(
          url: api.next!, urls: [...urls, ...api.results]);
    } catch (e) {
      return [];
    }
  }
}
