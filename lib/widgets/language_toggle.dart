import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/keyboard_provider.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Language: ', style: TextStyle(fontSize: 16)),
          Switch(
            value: provider.isBangla,
            onChanged: (_) => provider.toggleLanguage(),
            activeColor: Colors.blue,
          ),
          Text(
            provider.isBangla ? 'বাংলা' : 'English',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}