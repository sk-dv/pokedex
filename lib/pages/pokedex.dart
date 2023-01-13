import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/application/pokemon_list_cubit.dart';
import 'package:pokedex/data/pokedex_locator.dart';
import 'package:pokedex/data/pokemon_list_controller.dart';
import 'package:pokedex/models/menu.dart';
import 'package:pokedex/widgets/pokedex_navbar.dart';
import 'package:pokedex/widgets/pokemon_list.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({super.key});

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  Menu current = Menu.pokedex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark
                .copyWith(statusBarColor: Colors.transparent),
            elevation: 0,
          ),
          body: Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  current.name,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                BlocProvider(
                  create: (_) => PokemonListCubit(
                      PokedexLocator.locator.get<PokemonListController>()),
                  child: const PokemonList(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: PokedexNavbar(
            current,
            onPokedex: () => setState(() => current = Menu.pokedex),
            onFavourites: () => setState(() => current = Menu.favourites),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SvgPicture.asset('assets/pokeball.svg',
              color: const Color(0xFF303943)),
        ),
      ],
    );
  }
}
