import 'package:flutter/material.dart';
import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/models/pokemon_data.dart';

import 'list_frame.dart';
import 'pokemon_frame.dart';

class WrappedPokemonList extends StatelessWidget {
  const WrappedPokemonList(
    this.items,
    this.cubit, {
    required this.builder,
    this.isLoading = false,
    super.key,
  });

  final List<PokemonData> items;
  final PokedexCubit cubit;
  final Widget Function(int id, Widget child) builder;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      children: [
        ...items.map((data) {
          return builder(
            data.id,
            Stack(
              children: [
                PokemonFrame(data),
                Positioned(
                  right: 12,
                  bottom: 17,
                  child: Image.network(data.pokemon!.image, width: 70),
                ),
                Positioned(
                  right: 7,
                  bottom: 12,
                  child: IconButton(
                    icon: Icon(
                      data.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                    ),
                    iconSize: 30,
                    color: data.pokemon!.pokemonColor.textColor,
                    onPressed: () {
                      cubit.markAsFavorite(data);
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        if (isLoading)
          const ListFrame(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            ),
          ),
      ],
    );
  }
}
