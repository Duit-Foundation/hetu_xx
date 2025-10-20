import "package:hetu_script/parser/token.dart";
import "package:hetu_script/lexicon/lexicon.dart";
import "package:hetu_script/lexicon/lexicon_hetu.dart";

abstract class HTLexer {
  HTLexicon lexicon;

  HTLexer({HTLexicon? lexicon}) : lexicon = lexicon ?? HTLexiconHetu();

  /// Scan a string content and convert it into a linked list of tokens.
  /// The last element in the list will always be a `end_of_file` token.
  Token lex(String content, {int line = 1, int column = 1, int offset = 0});
}
