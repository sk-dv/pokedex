import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/pokedex_cubit.dart';
import 'package:pokedex/models/extended_build_context.dart';

class SearchModal {
  static Future<T?> open<T>(
    BuildContext context,
    FocusNode node,
    PokedexCubit cubit,
  ) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            20,
            10,
            20,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF4F5F4),
                ),
                width: context.width * 0.3,
                height: 5,
              ),
              const SizedBox(height: 20),
              TextField(
                focusNode: node,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'Search Pokemon by name/number',
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Icon(
                      Icons.search,
                      color: Color(0xFF303943),
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  cubit.search(value);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
