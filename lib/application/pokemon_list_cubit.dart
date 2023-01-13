import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:pokedex/data/pokemon_list_controller.dart';
import 'package:pokedex/models/pokemon_url.dart';

class PokemonListState {
  const PokemonListState({required this.urls, required this.status});

  final List<PokemonUrl> urls;
  final FormzStatus status;

  static const PokemonListState empty =
      PokemonListState(urls: [], status: FormzStatus.pure);

  PokemonListState copy({List<PokemonUrl>? urls, FormzStatus? status}) {
    return PokemonListState(
        urls: urls ?? this.urls, status: status ?? this.status);
  }
}

class PokemonListCubit extends Cubit<PokemonListState> {
  PokemonListCubit(this._controller) : super(PokemonListState.empty);

  final PokemonListController _controller;

  void cacheChecking() async {
    emit(state.copy(status: FormzStatus.submissionInProgress));

    final urls = await _controller.cacheChecking();

    emit(state.copy(
      status: urls.isNotEmpty ? FormzStatus.valid : FormzStatus.invalid,
      urls: urls,
    ));
  }
}
