import "package:hetu_xx/lexer/lexer.dart";
import "package:hetu_xx/lexer/lexer_hetu.dart";
import "package:hetu_xx/parser/token.dart";
import "package:test/test.dart";

Token? _retriveLastToken(Token tkn) {
  final tok = tkn.next;

  if (tok != null) {
    if (tok.lexeme == Token.endOfFile) {
      return tkn;
    } else {
      return _retriveLastToken(tok);
    }
  } else {
    return tkn;
  }
}

void main() {
  late final HTLexer lexer;

  setUpAll(() {
    lexer = HTLexerHetu();
  });

  group("Numbers", () {
    group("integer", () {
      test("default", () {
        final token = lexer.lex("2");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, 2);
      });

      test("must handle negative integer literal", () {
        final token = lexer.lex("-2");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, -2);
      });

      test("must handle zero integer literal", () {
        final token = lexer.lex("0");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, 0);
      });

      test("must handle large integer literal", () {
        final token = lexer.lex("123456789");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, 123456789);
      });
    });

    group("float", () {
      test("default", () {
        final token = lexer.lex("2.5");
        expect(token, isA<TokenFloatLiteral>());
        expect((token as TokenFloatLiteral).literal, 2.5);
      });

      test("negative", () {
        final token = lexer.lex("-2.5");
        expect(token, isA<TokenFloatLiteral>());
        expect((token as TokenFloatLiteral).literal, -2.5);
      });

      test("start with dot", () {
        final token = lexer.lex(".5");
        expect(token, isA<TokenFloatLiteral>());
        expect((token as TokenFloatLiteral).literal, 0.5);
      });

      test("negative start with dot", () {
        final token = lexer.lex("-.5");
        expect(token, isA<TokenFloatLiteral>());
        expect((token as TokenFloatLiteral).literal, -0.5);
      });

      test("ends with dot", () {
        final token = lexer.lex("5.");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, 5);
      });

      test("trailing zeros", () {
        final token = lexer.lex("5.500000000000000");
        expect(token, isA<TokenFloatLiteral>());
        expect((token as TokenFloatLiteral).literal, 5.5);
      });
    });

    group("hex", () {
      /**
       * Bug with hex values lexical analysis
       * 
       * lexer_hetu.dart:442
       * 
       * The last character of hexadecimal numbers is reduced, as a result of which the token has an incorrect value.
       */
      test("default", () {
        final token = lexer.lex("0x1A");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, 26);
      });

      test("negative", () {
        final token = lexer.lex("-0x1A");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, -26);
      });

      test("upper/lower/mixed case", () {
        final tokenUC = lexer.lex("0xFF");
        final tokenLC = lexer.lex("0xff");
        final tokenMC = lexer.lex("0xAbCd");
        expect(tokenUC, isA<TokenIntegerLiteral>());
        expect((tokenUC as TokenIntegerLiteral).literal, 255);
        expect(tokenLC, isA<TokenIntegerLiteral>());
        expect((tokenLC as TokenIntegerLiteral).literal, 255);
        expect(tokenMC, isA<TokenIntegerLiteral>());
        expect((tokenMC as TokenIntegerLiteral).literal, 43981);
      });
    }, skip: true);
  });

  group("Boolean", () {
    test("literals", () {
      final tokenTrue = lexer.lex("true");
      expect(tokenTrue, isA<TokenBooleanLiteral>());
      expect(tokenTrue.literal, true);
      final tokenFalse = lexer.lex("false");
      expect(tokenFalse, isA<TokenBooleanLiteral>());
      expect(tokenFalse.literal, false);
    });
  });

  group("Strings", () {
    test("must handle boolean literal", () {
      final token = lexer.lex("true");
      expect(token, isA<TokenBooleanLiteral>());
      print(token.literal);
      final token2 = lexer.lex("false");
      expect(token2, isA<TokenBooleanLiteral>());
      print(token2.literal);
    });

    test("empty line", () {
      final token = lexer.lex("""
    1

    """);
      expect(token.next, isA<TokenEmptyLine>());
    });

    test("singlequote literal", () {
      final token = lexer.lex("'test'");
      expect(token, isA<TokenStringLiteral>());
    });

    test("doublequote literal", () {
      final token = lexer.lex("\"test\"");
      expect(token, isA<TokenStringLiteral>());
    });
  });
}
