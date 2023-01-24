import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/widgets/wrapped_pokemon_list.dart';

class PokemonList extends StatelessWidget {
  const PokemonList(this.cubit, {super.key});

  final PokedexCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokedexCubit, PokedexState>(
      builder: (context, state) {
        if (state.found.isNotEmpty) {
          return WrappedPokemonList(
            state.found,
            cubit,
            builder: (int id, Widget child) => child,
          );
        }

        return WrappedPokemonList(
          state.validData,
          cubit,
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
