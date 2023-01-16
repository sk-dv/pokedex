import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_data.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon(
    this.data, {
    required this.onPressed,
    super.key,
  });

  final PokemonData data;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        data.isFavorite
            ? Icons.favorite_rounded
            : Icons.favorite_outline_rounded,
      ),
      iconSize: 30,
      color: data.pokemon!.pokemonColor.textColor,
      onPressed: onPressed,
    );
  }
}
