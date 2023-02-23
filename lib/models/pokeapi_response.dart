import 'pokemon_data.dart';

class PokeApiResponse {
  const PokeApiResponse._({
    required this.count,
    required this.next,
    required this.results,
  });

  final int count;
  final String? next;
  final List<PokemonData> results;

  factory PokeApiResponse.fromJson(
    int offset,
    int limit,
    Map<String, dynamic> json,
  ) {
    final results = List.from(json['results']);
    final data = <PokemonData>[];

    /// con los limites {offset} y {limit} se determine en que rango de números
    /// se va a iterar.
    for (int idx = offset; idx < offset + limit; idx += 1) {
      data.add(PokemonData.fromJson(
        /// {PokemonData} obtiene como {id} el índice actual.
        idx,
        results[idx - offset],
      ));
    }

    return PokeApiResponse._(
      count: json['count'],
      next: json['next'],
      results: data,
    );
  }
}
