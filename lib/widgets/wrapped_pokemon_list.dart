import 'dart:io';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/data/image_downloader.dart';
import 'package:pokedex/data/pokedex_locator.dart';
import 'package:pokedex/models/menu.dart';
import 'package:pokedex/models/pokemon_data.dart';
import 'package:pokedex/widgets/pokemon_route_data.dart';
import 'pokemon_frame.dart';

class WrappedPokemonList extends StatelessWidget {
  const WrappedPokemonList(
    this.items,
    this.cubit, {
    required this.builder,
    this.menu = Menu.pokedex,
    super.key,
  });

  final List<PokemonData> items;
  final PokedexCubit cubit;
  final Widget Function(int id, Widget child) builder;
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: 25,
        children: [
          ...items.map((data) {
            File? file;

            if (data.pokemon!.image != null) {
              final downloader = PokedexLocator.locator.get<ImageDownloader>();
              file = downloader.readImage(data.pokemon!.image!);
            }

            return builder(
              data.id,
              Stack(
                children: [
                  GestureDetector(
                    child: PokemonFrame(data),
                    onTap: () {
                      context.go('/pokemon',
                          extra: PokemonRouteData(data, menu));
                    },
                  ),
                  if (file != null)
                    Positioned(
                      right: 12,
                      bottom: 17,
                      child: GestureDetector(
                        child: Image.file(file, width: 80),
                        onTap: () {
                          context.go(
                            '/pokemon',
                            extra: PokemonRouteData(data, menu),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
