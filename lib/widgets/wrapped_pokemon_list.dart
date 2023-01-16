import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/models/menu.dart';
import 'package:pokedex/models/pokemon_data.dart';
import 'package:pokedex/widgets/favorite_icon.dart';
import 'package:pokedex/widgets/pokemon_route_data.dart';

import 'list_frame.dart';
import 'pokemon_frame.dart';

class WrappedPokemonList extends StatelessWidget {
  const WrappedPokemonList(
    this.items,
    this.cubit, {
    required this.builder,
    this.isLoading = false,
    this.menu = Menu.pokedex,
    super.key,
  });

  final List<PokemonData> items;
  final PokedexCubit cubit;
  final Widget Function(int id, Widget child) builder;
  final bool isLoading;
  final Menu menu;

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
                GestureDetector(
                  child: PokemonFrame(data),
                  onTap: () {
                    context.go('/pokemon', extra: PokemonRouteData(data, menu));
                  },
                ),
                if (data.pokemon!.image != null)
                  Positioned(
                    right: 12,
                    bottom: 17,
                    child: GestureDetector(
                      child: Image.network(data.pokemon!.image!, width: 70),
                      onTap: () {
                        context.go(
                          '/pokemon',
                          extra: PokemonRouteData(data, menu),
                        );
                      },
                    ),
                  ),
                Positioned(
                  right: 7,
                  bottom: 12,
                  child: FavoriteIcon(
                    data,
                    onPressed: () => cubit.toggleFavorite(data),
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
