import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(0xFF6C79DB),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
