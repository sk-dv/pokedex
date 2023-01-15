import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_color.dart';
import 'package:pokedex/models/pokemon_data.dart';
import 'package:pokedex/models/pokemon_url.dart';

class PokedexCache {
  const PokedexCache._(this.key);

  final String key;

  static Future<PokedexCache> init(String key) async {
    await Hive.initFlutter();

    Hive.registerAdapter(PokemonColorAdapter());
    Hive.registerAdapter(PokemonAdapter());
    Hive.registerAdapter(PokemonUrlAdapter());
    Hive.registerAdapter(PokemonDataAdapter());

    return PokedexCache._(key);
  }

  Future<List<PokemonData>> readPokemonDataList() async {
    final box = await Hive.openBox<PokemonData>(key);
    final values = box.values.toList();

    await box.close();
    return values;
  }

  Future<int> writePokemonDataList(List<PokemonData> values) async {
    final box = await Hive.openBox<PokemonData>(key);

    if (values.isNotEmpty) {
      for (final value in values) {
        await box.put(value.id, value);
      }
    }

    final writtenElements = box.values.toList();
    await box.close();

    return writtenElements.length;
  }

  Future<PokemonData> updatePokemonData(int idx, Pokemon pokemon) async {
    final box = await Hive.openBox<PokemonData>(key);

    final data = box.values.firstWhere((data) => data.id == idx,
        orElse: () => box.values.toList()[idx]);

    final updated = data.copyPokemon(pokemon);

    await box.put(idx, updated);
    await box.close();

    return updated;
  }

  Future<PokemonData> getPokemonData(int idx) async {
    final box = await Hive.openBox<PokemonData>(key);
    return box.values.where((data) => data.id == idx).first;
  }
}
