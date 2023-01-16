import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/models/menu.dart';

import 'wrapped_pokemon_list.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList(this.cubit, {super.key});

  final PokedexCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokedexCubit, PokedexState>(
      builder: (context, state) {
        return WrappedPokemonList(
          state.favorites,
          cubit,
          builder: (id, child) => child,
          menu: Menu.favorites,
        );
      },
    );
  }
}
