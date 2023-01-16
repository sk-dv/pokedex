import 'package:flutter/material.dart';

import 'package:pokedex/models/extended_build_context.dart';

class ListFrame extends StatelessWidget {
  const ListFrame({
    required this.child,
    this.color = Colors.transparent,
    super.key,
  });

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.40,
      height: context.height * 0.15,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: SizedBox(width: context.width, child: child),
    );
  }
}
