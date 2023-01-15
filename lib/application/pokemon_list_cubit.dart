import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:pokedex/data/pokemon_list_controller.dart';
import 'package:pokedex/models/pokemon_data.dart';

class PokemonListState {
  const PokemonListState({required this.status, required this.pokemonData});

  final FormzStatus status;
  final List<PokemonData> pokemonData;

  static const PokemonListState empty =
      PokemonListState(status: FormzStatus.pure, pokemonData: []);

  PokemonListState copy({
    FormzStatus? status,
    List<PokemonData>? pokemonData,
  }) {
    return PokemonListState(
      status: status ?? this.status,
      pokemonData: pokemonData ?? this.pokemonData,
    );
  }
}

class PokemonListCubit extends Cubit<PokemonListState> {
  PokemonListCubit(this._controller) : super(PokemonListState.empty);

  final PokemonListController _controller;

  void cacheChecking() async {
    emit(state.copy(status: FormzStatus.submissionInProgress));

    final data = await _controller.cacheChecking();

    emit(state.copy(
      status: data.isNotEmpty ? FormzStatus.valid : FormzStatus.invalid,
      pokemonData: data,
    ));
  }

  void updatePokemonData() async {
    emit(state.copy(status: FormzStatus.submissionInProgress));

    final data = await _controller.retrievePokemonData(state.pokemonData);

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
}

extension ReversedString on String {
  List<String> reversedAsList() {
    return runes.map((r) => String.fromCharCode(r)).toList().reversed.toList();
  }
}
