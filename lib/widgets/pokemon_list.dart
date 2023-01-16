import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/widgets/list_frame.dart';
import 'package:pokedex/widgets/pokemon_frame.dart';
import 'package:pokedex/widgets/wrapped_pokemon_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PokemonList extends StatelessWidget {
  const PokemonList(this.cubit, {super.key});

  final PokedexCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokedexCubit, PokedexState>(
      listenWhen: (prev, next) {
        return prev.pokemonData.length != next.pokemonData.length;
      },
      listener: (context, state) {
        if (state.pokemonData.isNotEmpty) cubit.updatePokemonData();
      },
      builder: (context, state) {
        return WrappedPokemonList(
          state.validData,
          cubit,
          isLoading: state.status.isSubmissionInProgress,
          builder: (int id, Widget child) {
            return VisibilityDetector(
              key: Key('PokemonList_$id'),
              onVisibilityChanged: (info) {
                cubit.checkListReach((info.visibleFraction * 100).toInt(), id);
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
