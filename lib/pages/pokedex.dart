import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/data/pokedex_cache.dart';
import 'package:pokedex/data/pokedex_locator.dart';
import 'package:pokedex/data/pokemon_list_controller.dart';
import 'package:pokedex/models/menu.dart';
import 'package:pokedex/widgets/persistent_title.dart';
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
          body: BlocProvider(
            create: (_) => PokedexCubit(
              PokedexLocator.locator.get<PokemonListController>(),
            )..cacheChecking(),
            child: Builder(builder: (context) {
              return Container(
                padding: const EdgeInsets.all(30),
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: PersistentTitle(current.name),
                    ),
                    SliverToBoxAdapter(
                      child: current.content(context.read<PokedexCubit>()),
                    ),
                  ],
                ),
              );
            }),
          ),
          bottomNavigationBar: PokedexNavbar(
            current,
            onPokedex: () => setState(() => current = Menu.pokedex),
            onFavorites: () => setState(() => current = Menu.favorites),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SvgPicture.asset(
            'assets/pokeball.svg',
            color: const Color(0xFF303943),
          ),
        ),
      ],
    );
  }
}
