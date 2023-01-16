import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/models/menu.dart';
import 'package:pokedex/widgets/floating_button.dart';
import 'package:pokedex/widgets/persistent_title.dart';
import 'package:pokedex/widgets/pokedex_navbar.dart';
import 'package:pokedex/widgets/search_modal.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({Menu? menu, super.key}) : menu = menu ?? Menu.pokedex;

  final Menu menu;

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  late Menu current;

  @override
  void initState() {
    current = widget.menu;
    super.initState();
  }

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
          body: Builder(builder: (context) {
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
          floatingActionButton: BlocBuilder<PokedexCubit, PokedexState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (state.found.isNotEmpty)
                    FloatingButton(
                      onPressed: context.read<PokedexCubit>().cleanSearch,
                      icon: Icons.clear,
                    ),
                  const SizedBox(width: 10),
                  FloatingButton(
                    onPressed: () {
                      final node = FocusNode();
                      node.requestFocus();
                      SearchModal.open(
                        context,
                        node,
                        context.read<PokedexCubit>(),
                      );
                    },
                    icon: Icons.search,
                  ),
                ],
              );
            },
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
