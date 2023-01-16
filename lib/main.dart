import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pokedex/data/pokedex_locator.dart';
import 'package:pokedex/pages/pokemon_detail.dart';
import 'package:pokedex/widgets/pokemon_route_data.dart';
import 'application/pokedex_cubit.dart';
import 'data/pokemon_list_controller.dart';
import 'models/menu.dart';
import 'pages/pokedex.dart';

void main() async {
  await PokedexLocator.setup();
  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  GoRouter get _router {
    final pokedexCubit = PokedexCubit(
      PokedexLocator.locator.get<PokemonListController>(),
    );

    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider.value(
            value: pokedexCubit..cacheChecking(),
            child: Pokedex(
              menu: state.extra == null ? null : state.extra as Menu,
            ),
          ),
        ),
        GoRoute(
          path: '/pokemon',
          builder: (context, state) {
            return BlocProvider.value(
              value: pokedexCubit,
              child: PokemonDetail(state.extra as PokemonRouteData),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.transparent.withOpacity(0.1),
        ),
      ),
    );
  }
}
