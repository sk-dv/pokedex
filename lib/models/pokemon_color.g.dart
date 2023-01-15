// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_color.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonColorAdapter extends TypeAdapter<PokemonColor> {
  @override
  final int typeId = 4;

  @override
  PokemonColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PokemonColor.black;
      case 1:
        return PokemonColor.blue;
      case 2:
        return PokemonColor.brown;
      case 3:
        return PokemonColor.gray;
      case 4:
        return PokemonColor.green;
      case 5:
        return PokemonColor.pink;
      case 6:
        return PokemonColor.purple;
      case 7:
        return PokemonColor.red;
      case 8:
        return PokemonColor.white;
      case 9:
        return PokemonColor.yellow;
      case 10:
        return PokemonColor.none;
      default:
        return PokemonColor.black;
    }
  }

  @override
  void write(BinaryWriter writer, PokemonColor obj) {
    switch (obj) {
      case PokemonColor.black:
        writer.writeByte(0);
        break;
      case PokemonColor.blue:
        writer.writeByte(1);
        break;
      case PokemonColor.brown:
        writer.writeByte(2);
        break;
      case PokemonColor.gray:
        writer.writeByte(3);
        break;
      case PokemonColor.green:
        writer.writeByte(4);
        break;
      case PokemonColor.pink:
        writer.writeByte(5);
        break;
      case PokemonColor.purple:
        writer.writeByte(6);
        break;
      case PokemonColor.red:
        writer.writeByte(7);
        break;
      case PokemonColor.white:
        writer.writeByte(8);
        break;
      case PokemonColor.yellow:
        writer.writeByte(9);
        break;
      case PokemonColor.none:
        writer.writeByte(10);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
