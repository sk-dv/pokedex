import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pokedex/application/pokemon_list_cubit.dart';
import 'package:pokedex/models/extended_build_context.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonListCubit, PokemonListState>(
      listenWhen: (prev, next) {
        return prev.pokemonData.length != next.pokemonData.length;
      },
      listener: (context, state) {
        if (state.pokemonData.isNotEmpty) {
          context.read<PokemonListCubit>().updatePokemonData();
        }
      },
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            ),
          );
        }

        return Wrap(
          spacing: 15,
          children: state.pokemonData
              .where((data) => data.pokemon != null)
              .map((data) {
            return Stack(
              children: [
                Container(
                  width: context.width * 0.40,
                  height: context.height * 0.15,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: data.pokemon?.color.withOpacity(0.7),
                  ),
                  child: SizedBox(
                    width: context.width,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            context
                                .read<PokemonListCubit>()
                                .getPokemonIndex(data.id + 1),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data.pokemon!.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: data.pokemon!.color,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 17,
                  child: Image.network(data.pokemon!.image, width: 70),
                ),
                const Positioned(
                  right: 7,
                  bottom: 12,
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
