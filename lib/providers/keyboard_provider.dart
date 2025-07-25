import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../utils/key_mappings.dart';

class KeyboardProvider extends ChangeNotifier {
  bool _isBangla = false;
  final TextEditingController _textController = TextEditingController();
  List<String> _suggestions = [];
  String _currentInput = '';

  // Getters
  bool get isBangla => _isBangla;
  TextEditingController get textController => _textController;
  List<String> get suggestions => _suggestions;

  // Toggle language with vibration feedback
  Future<void> toggleLanguage() async {
    _isBangla = !_isBangla;
    try {
      if (await Vibration.hasVibrator() ?? false) {
        await Vibration.vibrate(duration: 50);
      }
    } catch (e) {
      debugPrint('Vibration error: $e');
    }
    notifyListeners();
  }

  // Handle key press with vibration
  Future<void> handleKeyPress(String englishChar, String banglaChar) async {
    final String char = _isBangla ? banglaChar : englishChar;
    final text = _textController.text;
    final selection = _textController.selection;

    try {
      if (selection.isValid) {
        final newText = text.replaceRange(selection.start, selection.end, char);
        _textController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
            offset: selection.start + char.length,
          ),
        );
      } else {
        _textController.text += char;
      }

      _currentInput += char;
      _updateSuggestions();

      try {
        if (await Vibration.hasVibrator() ?? false) {
          await Vibration.vibrate(duration: 30);
        }
      } catch (e) {
        debugPrint('Vibration error: $e');
      }
    } catch (e) {
      debugPrint('Key press error: $e');
    } finally {
      notifyListeners();
    }
  }

  // Handle backspace
  Future<void> handleBackspace() async {
    final text = _textController.text;
    if (text.isEmpty) return;

    final selection = _textController.selection;
    if (!selection.isValid || selection.start == 0) return;

    try {
      final newText = text.replaceRange(selection.start - 1, selection.start, '');
      _textController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.start - 1,
        ),
      );

      _currentInput = _currentInput.isNotEmpty
          ? _currentInput.substring(0, _currentInput.length - 1)
          : '';
      _updateSuggestions();

      try {
        if (await Vibration.hasVibrator() ?? false) {
          await Vibration.vibrate(duration: 30);
        }
      } catch (e) {
        debugPrint('Vibration error: $e');
      }
    } catch (e) {
      debugPrint('Backspace error: $e');
    } finally {
      notifyListeners();
    }
  }

  // Select suggestion
  Future<void> selectSuggestion(String word) async {
    try {
      _textController.text = word;
      _currentInput = '';
      _suggestions = [];

      try {
        if (await Vibration.hasVibrator() ?? false) {
          await Vibration.vibrate(duration: 100);
        }
      } catch (e) {
        debugPrint('Vibration error: $e');
      }
    } catch (e) {
      debugPrint('Suggestion error: $e');
    } finally {
      notifyListeners();
    }
  }

  // Update suggestions
  void _updateSuggestions() {
    try {
      _suggestions = KeyMappings.getSuggestions(_currentInput, _isBangla);
    } catch (e) {
      debugPrint('Suggestion update error: $e');
      _suggestions = [];
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}