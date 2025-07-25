import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/keyboard_provider.dart';

class SuggestionBar extends StatelessWidget {
  final List<String> suggestions;

  const SuggestionBar({super.key, required this.suggestions});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);

    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () => provider.selectSuggestion(suggestions[index]),
              child: Text(
                suggestions[index],
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: provider.isBangla ? 'SiyamRupali' : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}