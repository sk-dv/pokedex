import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/data/image_downloader.dart';
import 'package:pokedex/data/pokedex_locator.dart';
import 'package:pokedex/models/extended_build_context.dart';
import 'package:pokedex/widgets/favorite_icon.dart';
import 'package:pokedex/widgets/pokemon_route_data.dart';

class PokemonDetail extends StatelessWidget {
  const PokemonDetail(this.route, {super.key});

  final PokemonRouteData route;

  @override
  Widget build(BuildContext context) {
    File? file;

    if (route.data.pokemon!.image != null) {
      final downloader = PokedexLocator.locator.get<ImageDownloader>();
      file = downloader.readImage(route.data.pokemon!.image!);
    }

    return WillPopScope(
      onWillPop: () async {
        context.go('/', extra: route.menu);
        return false;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              height: context.height,
              color: Colors.white,
              child: Container(
                height: context.height,
                color: route.data.pokemon!.pokemonColor.color.withOpacity(0.7),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              systemOverlayStyle:
                  route.data.pokemon!.pokemonColor.statusBarColor,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: route.data.pokemon!.pokemonColor.textColor,
                ),
                onPressed: () => context.go('/', extra: route.menu),
              ),
              actions: [FavoriteIcon(route.data, onPressed: () {})],
            ),
            body: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            route.data.pokemon!.name,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: route.data.pokemon!.pokemonColor.textColor,
                            ),
                          ),
                          Row(
                            children: route.data.pokemon!.types.map((type) {
                              return Container(
                                margin: const EdgeInsets.only(right: 5),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: route
                                      .data.pokemon!.pokemonColor.textColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        route.data.pokemon!.pokemonColor.color,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            context
                                .read<PokedexCubit>()
                                .getPokemonIndex(route.data.id + 1),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: route.data.pokemon!.pokemonColor.textColor
                                  .withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (route.data.pokemon!.genera.isNotEmpty)
                            Text(
                              route.data.pokemon!.genera,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    route.data.pokemon!.pokemonColor.textColor,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  if (file != null)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 60),
                      child: Image.file(file, width: 250),
                    ),
                  if (route.data.pokemon!.description.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: route.data.pokemon!.pokemonColor.textColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        route.data.pokemon!.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: route.data.pokemon!.pokemonColor.color,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
