import 'package:hive_flutter/hive_flutter.dart';

class PokedexCache {
  const PokedexCache._(this.key);

  final String key;

  static Future<PokedexCache> init(String key) async {
    await Hive.initFlutter();
    return PokedexCache._(key);
  }

  Future<List<T>> readList<T>() async {
    final pokemonBox = await Hive.openBox<T>(key);
    return pokemonBox.values.toList();
  }

  Future<int> writeList<T>(List<T> values) async {
    final box = await Hive.openBox<T>(key);

    if (values.isNotEmpty) {
      for (final value in values) {
        await box.add(value);
      }
    }

    final writtenElements = box.values.toList();
    box.close();

    return writtenElements.length;
  }
}
