import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/models/menu.dart';

class MenuOption extends StatelessWidget {
  const MenuOption(
    this.menu, {
    super.key,
    required this.enableOption,
    required this.onTap,
  });

  final Menu menu;
  final bool enableOption;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            menu.asset,
            width: 30,
            color: enableOption ? menu.enableColor : menu.disableColor,
          ),
          const SizedBox(height: 5),
          Text(
            menu.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: enableOption ? menu.enableColor : menu.disableColor,
            ),
          ),
        ],
      ),
    );
  }
}
