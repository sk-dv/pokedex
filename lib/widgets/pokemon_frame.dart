import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/models/pokemon_data.dart';
import 'package:pokedex/widgets/list_frame.dart';

class PokemonFrame extends StatelessWidget {
  const PokemonFrame(this.data, {super.key});

  final PokemonData data;

  @override
  Widget build(BuildContext context) {
    return ListFrame(
      color: data.pokemon!.pokemonColor.color.withOpacity(0.7),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              context.read<PokedexCubit>().getPokemonIndex(data.id + 1),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: data.pokemon!.pokemonColor.textColor.withOpacity(0.5),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              data.pokemon!.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: data.pokemon!.pokemonColor.textColor,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.pokemon!.types.map((type) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: data.pokemon!.pokemonColor.textColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 12,
                      color: data.pokemon!.pokemonColor.color,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
