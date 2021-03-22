import 'package:tarbus2021/model/entity/unwanted_letter_holder.dart';

class StringUtils {
  static String removeLowercasePolishLetters(String text) {
    var unwantedLetters = <UnwantedLetterHolder>[
      UnwantedLetterHolder('ą', 'a'),
      UnwantedLetterHolder('ć', 'c'),
      UnwantedLetterHolder('ę', 'e'),
      UnwantedLetterHolder('ł', 'l'),
      UnwantedLetterHolder('ń', 'n'),
      UnwantedLetterHolder('ó', 'o'),
      UnwantedLetterHolder('ś', 's'),
      UnwantedLetterHolder('ź', 'z'),
      UnwantedLetterHolder('ż', 'z'),
    ];

    for (var unwantedLetter in unwantedLetters) {
      text = text.replaceAll(unwantedLetter.oldChar, unwantedLetter.newChar);
    }
    return text;
  }
}
