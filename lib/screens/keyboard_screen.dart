import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/keyboard_provider.dart';
import '../widgets/keyboard_key.dart';
import '../widgets/language_toggle.dart';
import '../widgets/suggestion_bar.dart';
import '../utils/key_mappings.dart';

class KeyboardScreen extends StatelessWidget {
  const KeyboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bangla-English Keyboard'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Consumer<KeyboardProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  // Text input field with constrained height
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight * 0.4, // 40% of screen
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: TextField(
                                controller: provider.textController,
                                maxLines: null,
                                expands: true,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: provider.isBangla
                                      ? 'এখানে টাইপ করুন...'
                                      : 'Type here...',
                                ),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: provider.isBangla
                                      ? 'SiyamRupali'
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          if (provider.suggestions.isNotEmpty)
                            SuggestionBar(suggestions: provider.suggestions),
                        ],
                      ),
                    ),
                  ),

                  // Keyboard area - takes remaining space
                  Expanded(
                    child: Container(
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const LanguageToggle(),
                          _buildKeyboardRow(context, KeyMappings.row1),
                          _buildKeyboardRow(context, KeyMappings.row2),
                          _buildKeyboardRow(context, KeyMappings.row3),
                          _buildSpecialKeysRow(context),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildKeyboardRow(BuildContext context, List<String> keys) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: keys.map((key) => Expanded(
          child: KeyboardKey(
            englishChar: key,
            banglaChar: KeyMappings.getBangla(key),
            isActive: provider.isBangla,
            onTap: () => provider.handleKeyPress(key, KeyMappings.getBangla(key)),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSpecialKeysRow(BuildContext context) {
    final provider = Provider.of<KeyboardProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          // Backspace key
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: IconButton(
                icon: const Icon(Icons.backspace),
                onPressed: provider.handleBackspace,
              ),
            ),
          ),
          // Space key
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: SizedBox(
                height: 48, // Fixed height for consistency
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => provider.handleKeyPress(' ', ' '),
                  child: const Text('Space'),
                ),
              ),
            ),
          ),
          // Enter key
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: SizedBox(
                height: 48, // Matches space key height
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => provider.handleKeyPress('\n', '\n'),
                  child: const Text('↵'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}