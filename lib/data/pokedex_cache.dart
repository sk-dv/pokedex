import 'package:hive_flutter/hive_flutter.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_color.dart';
import 'package:pokedex/models/pokemon_data.dart';
import 'package:pokedex/models/pokemon_url.dart';

class PokedexCache {
  const PokedexCache._();

  static Future<PokedexCache> get init async {
    await Hive.initFlutter();

    Hive.registerAdapter(PokemonColorAdapter());
    Hive.registerAdapter(PokemonAdapter());
    Hive.registerAdapter(PokemonUrlAdapter());
    Hive.registerAdapter(PokemonDataAdapter());

    return const PokedexCache._();
  }

  static const String offsetKey = 'Pokedex:Offset:List';
  static const String offsetKeyValue = 'Offset:Value';

  Future<int> getOffset() async {
    final box = await Hive.openBox<int>(offsetKey);
    final offset = box.get(offsetKeyValue);
    await box.close();
    return offset ?? 0;
  }

  Future<void> updateOffset(int offset) async {
    final box = await Hive.openBox<int>(offsetKey);
    await box.put(offsetKeyValue, offset);
    await box.close();
  }

  static const String pokedexKey = 'Pokedex:Pokemon:Box';

  Future<List<PokemonData>> readPokemonDataList() async {
    final box = await Hive.openBox<PokemonData>(pokedexKey);
    final values = box.values.toList();

    await box.close();
    return values;
  }

  Future<int> writePokemonDataList(List<PokemonData> values) async {
    final box = await Hive.openBox<PokemonData>(pokedexKey);

    if (values.isNotEmpty) {
      for (final value in values) {
        await box.put(value.id, value);
      }
    }

    final writtenElements = box.values.toList();
    await box.close();

    return writtenElements.length;
  }

  Future<PokemonData> updatePokemonData(PokemonData data) async {
    final box = await Hive.openBox<PokemonData>(pokedexKey);

    await box.put(data.id, data);
    await box.close();

    return data;
  }

  Future<PokemonData> getPokemonData(int idx) async {
    final box = await Hive.openBox<PokemonData>(pokedexKey);
    final data = box.values.where((data) => data.id == idx).first;
    await box.close();
    return data;
  }
}
