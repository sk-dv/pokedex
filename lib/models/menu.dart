import 'package:flutter/material.dart';

import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/widgets/favorites_content.dart';
import 'package:pokedex/widgets/pokemon_list.dart';

enum Menu {
  pokedex,
  favorites;

  String get name {
    switch (this) {
      case Menu.pokedex:
        return 'Poxedex';
      case Menu.favorites:
        return 'Favorites';
    }
  }

  Color get disableColor {
    return const Color(0xFFD7D7D7);
  }

  Color get enableColor {
    switch (this) {
      case Menu.pokedex:
        return const Color(0xFFFFCE4B);
      case Menu.favorites:
        return const Color(0xFFFF5B5B);
    }
  }

  String get asset {
    switch (this) {
      case Menu.pokedex:
        return 'assets/pokedex.svg';
      case Menu.favorites:
        return 'assets/favorites.svg';
    }
  }

  Widget content(PokedexCubit cubit) {
    switch (this) {
      case Menu.pokedex:
        return PokemonList(cubit);
      case Menu.favorites:
        return FavoritesList(cubit);
    }
  }
}
