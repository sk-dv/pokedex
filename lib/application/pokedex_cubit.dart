import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:pokedex/data/pokemon_list_controller.dart';
import 'package:pokedex/models/pokemon_data.dart';

class PokedexState {
  const PokedexState({
    required this.status,
    required this.pokemonData,
    required this.listOffset,
    required this.found,
  });

  final FormzStatus status;
  final List<PokemonData> pokemonData;
  final int listOffset;
  final List<PokemonData> found;

  static const PokedexState empty = PokedexState(
      status: FormzStatus.pure, pokemonData: [], listOffset: 0, found: []);

  List<PokemonData> get validData {
    return pokemonData.where((data) => data.pokemon != null).toList();
  }

  List<PokemonData> get favorites {
    return pokemonData.where((data) => data.isFavorite).toList();
  }

  PokedexState copy({
    FormzStatus? status,
    List<PokemonData>? pokemonData,
    int? listOffset,
    List<PokemonData>? found,
  }) {
    return PokedexState(
      status: status ?? this.status,
      pokemonData: pokemonData ?? this.pokemonData,
      listOffset: listOffset ?? this.listOffset,
      found: found ?? this.found,
    );
  }
}

class PokedexCubit extends Cubit<PokedexState> {
  PokedexCubit(this._controller) : super(PokedexState.empty);

  final PokemonListController _controller;

  void cacheChecking() async {
    emit(state.copy(status: FormzStatus.submissionInProgress));

    final data = await _controller.cacheChecking();
    final offset = await _controller.getListOffset();

    emit(state.copy(
      status: data.isNotEmpty ? FormzStatus.valid : FormzStatus.invalid,
      pokemonData: data,
      listOffset: offset,
    ));
  }

  void checkListReach(int percentage, int currentId) {
    final idx = (state.listOffset + 25) - 1;
    final visible = percentage == 100;

    if (idx == currentId && visible) {
      /// load another twenty-five pokemon
      updatePokemonData(updatedOffset: true);
    }
  }

  void updatePokemonData({updatedOffset = false}) async {
    if (updatedOffset) {
      final offset = state.listOffset + 25;

      await _controller.saveListOffset(offset);
      emit(state.copy(listOffset: offset));
    }

    emit(state.copy(status: FormzStatus.submissionInProgress));

    final data = await _controller.retrievePokemonData(
      state.pokemonData,
      state.listOffset,
      state.listOffset + 25,
    );

    emit(state.copy(
      pokemonData: data,
      status: data.isNotEmpty ? FormzStatus.valid : FormzStatus.invalid,
    ));
  }

  String getPokemonIndex(int id) {
    final digits = state.pokemonData.length.toString().length;

    final idx = id.toString();

    final missingZeros = '0' * (digits - idx.reversedAsList().length);
    final reversedId = idx.reversedAsList().join() + missingZeros;

    return reversedId.reversedAsList().join();
  }

  void toggleFavorite(PokemonData data) async {
    final favorite = await _controller.markAsFavorite(
      data.copy(isFavorite: !data.isFavorite),
    );

    state.pokemonData[favorite.id] = favorite;
    emit(state.copy(pokemonData: state.pokemonData));
  }

  void search(String value) async {
    final found = state.pokemonData.where((data) {
      try {
        final id = int.parse(value) - 1;
        return data.id == id;
      } catch (e) {
        return data.pokemonUrl.name.contains(value);
      }
    }).toList();

    final updated = <PokemonData>[];

    for (final data in found) {
      updated.add(await _controller.checkPokemonData(data));
    }

    emit(state.copy(found: updated, status: FormzStatus.valid));
  }

  void cleanSearch() {
    emit(state.copy(found: []));
  }
}

extension ReversedString on String {
  List<String> reversedAsList() {
    return runes.map((r) => String.fromCharCode(r)).toList().reversed.toList();
  }
}
