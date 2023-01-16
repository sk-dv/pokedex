import 'package:flutter/material.dart';

import 'package:pokedex/models/extended_build_context.dart';
import 'package:pokedex/models/menu.dart';
import 'package:pokedex/widgets/menu_option.dart';

class PokedexNavbar extends StatelessWidget {
  const PokedexNavbar(this.current,
      {super.key, required this.onPokedex, required this.onFavorites});

  final Menu current;
  final void Function() onPokedex;
  final void Function() onFavorites;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.08,
      decoration: const BoxDecoration(color: Color(0xFFF4F4F4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MenuOption(Menu.pokedex,
              enableOption: current == Menu.pokedex, onTap: onPokedex),
          MenuOption(Menu.favorites,
              enableOption: current == Menu.favorites, onTap: onFavorites),
        ],
      ),
    );
  }
}
