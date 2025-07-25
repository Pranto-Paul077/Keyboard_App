class KeyMappings {
  // Complete English to Bangla character mapping
  static final Map<String, String> _banglaMap = {
    // First Row
    'q': 'ৎ', 'w': 'ও', 'e': 'ে', 'r': 'র', 't': 'ট',
    'y': 'য', 'u': 'ু', 'i': 'ি', 'o': 'ো', 'p': 'প',
    // Second Row
    'a': 'া', 's': 'স', 'd': 'দ', 'f': 'ফ', 'g': 'গ',
    'h': 'হ', 'j': 'জ', 'k': 'ক', 'l': 'ল',
    // Third Row
    'z': 'য', 'x': 'এ', 'c': 'চ', 'v': 'ভ', 'b': 'ব',
    'n': 'ন', 'm': 'ম',

    // Shifted characters
    'Q': 'ঞ', 'W': 'ঔ', 'E': 'ৠ', 'R': 'ঋ', 'T': 'ঠ',
    'Y': 'য়', 'U': 'ূ', 'I': 'ী', 'O': 'ৌ', 'P': 'ফ',
    'A': 'আ', 'S': 'শ', 'D': 'ধ', 'F': 'ঢ', 'G': 'ঘ',
    'H': 'ঃ', 'J': 'ঝ', 'K': 'খ', 'L': 'ঢ',
    'Z': 'ৃ', 'X': 'ঐ', 'C': 'ছ', 'V': 'ণ', 'B': 'ভ',
    'N': 'ণ', 'M': 'ং',

    // Numbers
    '1': '১', '2': '২', '3': '৩', '4': '৪', '5': '৫',
    '6': '৬', '7': '৭', '8': '৮', '9': '৯', '0': '০',

    // Punctuation
    ',': '্', '.': '।', '/': '?', '\\': '/', '[': '{',
    ']': '}', ';': 'ঃ', '\'': '"', '`': '্র',
  };

  // Keyboard rows
  static List<String> row1 = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'];
  static List<String> row2 = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'];
  static List<String> row3 = ['z', 'x', 'c', 'v', 'b', 'n', 'm'];
  static List<String> row4 = [',', '.', '?', '!', ' '];

  // Common word suggestions (English and Bangla)
  static final Map<String, List<String>> _wordSuggestions = {
    // English suggestions
    'e': ['edit', 'email', 'example'],
    'h': ['hello', 'hi', 'home'],
    'y': ['you', 'yes', 'year'],
    'he': ['hello', 'help', 'here'],
    'hel': ['hello', 'help', 'helium'],

    // Bangla suggestions
    'া': ['আমি', 'আপনি', 'আমার'],
    'ক': ['কেমন', 'কোথায়', 'কখন'],
    'ম': ['মা', 'মানুষ', 'মোবাইল'],
    'আম': ['আমি', 'আমার', 'আমাদের'],
    'ধ': ['ধন্যবাদ', 'ধরা', 'ধীরে'],

    // Combined words
    'hello': ['হ্যালো', 'নমস্কার', 'আদাব'],
    'name': ['নাম', 'নামটি', 'নাম কী'],
    'thank': ['ধন্যবাদ', 'আপনাকে ধন্যবাদ', 'থ্যাংক ইউ'],
    'how': ['কেমন', 'কিভাবে', 'হাউ'],
  };

  static String getBangla(String englishChar) {
    return _banglaMap[englishChar] ?? englishChar;
  }

  static List<String> getSuggestions(String input, bool isBanglaMode) {
    if (input.isEmpty) return [];

    // Check for direct matches
    if (_wordSuggestions.containsKey(input)) {
      return _wordSuggestions[input]!;
    }

    // Filter suggestions based on language and input
    return _wordSuggestions.entries
        .where((entry) => isBanglaMode
        ? entry.key.length > 1 || _banglaMap.containsValue(entry.key)
        : entry.key.length == 1 && _banglaMap.containsKey(entry.key))
        .expand((entry) => entry.value)
        .where((word) => word.toLowerCase().startsWith(input.toLowerCase()))
        .toList()
        .take(3)
        .toList();
  }
}