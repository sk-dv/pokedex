import 'pokemon_url.dart';

class PokeApiResponse {
  const PokeApiResponse._(
      {required this.count, required this.next, required this.results});

  final int count;
  final String? next;
  final List<PokemonUrl> results;

  factory PokeApiResponse.fromJson(Map<String, dynamic> json) {
    return PokeApiResponse._(
      count: json['count'],
      next: json['next'],
      results: List.from(json['results'])
          .map((result) => PokemonUrl.fromJson(result))
          .toList(),
    );
  }
}
