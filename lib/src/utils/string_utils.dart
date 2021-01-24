import 'package:tarbus2021/src/model/entity/unwanted_letter_holder.dart';

class StringUtils {
  static String removeLowercasePolishLetters( String text ) {
    List<UnwantedLetterHolder> unwantedLetters = [
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

    for (UnwantedLetterHolder unwantedLetter in unwantedLetters) {
      text = text.replaceAll(unwantedLetter.oldChar, unwantedLetter.newChar);
    }
    return text;
  }
}
