import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/data/pokedex_locator.dart';

import 'pages/pokedex.dart';

void main() async {
  await PokedexLocator.setup();
  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  GoRouter get _router {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Pokedex(),
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
