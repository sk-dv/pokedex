import 'package:flutter/material.dart';

enum Menu {
  pokedex,
  favourites;

  String get name {
    switch (this) {
      case Menu.pokedex:
        return 'Poxedex';
      case Menu.favourites:
        return 'Favourites';
    }
  }

  Color get disableColor {
    return const Color(0xFFD7D7D7);
  }

  Color get enableColor {
    switch (this) {
      case Menu.pokedex:
        return const Color(0xFFFFCE4B);
      case Menu.favourites:
        return const Color(0xFFFF5B5B);
    }
  }

  String get asset {
    switch (this) {
      case Menu.pokedex:
        return 'assets/pokedex.svg';
      case Menu.favourites:
        return 'assets/favorites.svg';
    }
  }
}
