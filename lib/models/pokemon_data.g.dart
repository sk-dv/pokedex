// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonDataAdapter extends TypeAdapter<PokemonData> {
  @override
  final int typeId = 1;

  @override
  PokemonData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonData(
      id: fields[0] as int,
      pokemonUrl: fields[1] as PokemonUrl,
      pokemon: fields[2] as Pokemon?,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pokemonUrl)
      ..writeByte(2)
      ..write(obj.pokemon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
