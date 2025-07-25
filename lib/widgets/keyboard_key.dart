import 'package:flutter/material.dart';

class KeyboardKey extends StatelessWidget {
  final String englishChar;
  final String banglaChar;
  final bool isActive;
  final VoidCallback onTap;

  const KeyboardKey({
    super.key,
    required this.englishChar,
    required this.banglaChar,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(4.0),
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              isActive ? banglaChar : englishChar,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: isActive ? 'SiyamRupali' : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}