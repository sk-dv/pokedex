import 'package:hive/hive.dart';

part 'pokemon_url.g.dart';

@HiveType(typeId: 1)
class PokemonUrl {
  PokemonUrl({required this.name, required this.url});

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  @override
  String toString() {
    return '$name: $url';
  }

  factory PokemonUrl.fromJson(Map<String, dynamic> json) {
    return PokemonUrl(name: json['name'], url: json['url']);
  }
}
