import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pokedex/application/pokemon_list_cubit.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  void initState() {
    context.read<PokemonListCubit>().cacheChecking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonListCubit, PokemonListState>(
      builder: (context, state) {
        print(state.urls);

        if (state.status.isSubmissionInProgress) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                  color: Colors.black, strokeWidth: 2),
            ),
          );
        }

        return Container();
      },
    );
  }
}
