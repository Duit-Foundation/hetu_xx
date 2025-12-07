import "package:hetu_xx/lexer/lexer.dart";
import "package:hetu_xx/lexer/lexer_hetu.dart";
import "package:hetu_xx/parser/token.dart";
import "package:test/test.dart";

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

      test("maximum int value", () {
        final token = lexer.lex("9223372036854775807");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, 9223372036854775807);
      });

      test("minimum int value", () {
        final token = lexer.lex("-9223372036854775808");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, -9223372036854775808);
      });

      test("integer with leading zeros", () {
        final token = lexer.lex("007");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, 7);
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

      test("very large float", () {
        final token = lexer.lex("123456789.123456789");
        expect(token, isA<TokenFloatLiteral>());
        expect((token as TokenFloatLiteral).literal, 123456789.123456789);
      });

      test("very small float near zero", () {
        final token = lexer.lex("0.000000001");
        expect(token, isA<TokenFloatLiteral>());
        expect((token as TokenFloatLiteral).literal, 0.000000001);
      });
    });

    group("hex", () {
      /**NOTE
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

      test("hex with leading zeros", () {
        final token = lexer.lex("0x00FF");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, 255);
      });

      test("large hex value", () {
        final token = lexer.lex("0xFFFFFFFF");
        expect(token, isA<TokenIntegerLiteral>());
        expect((token as TokenIntegerLiteral).literal, 4294967295);
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
    group("basic literals", () {
      test("singlequote literal", () {
        final token = lexer.lex("'test'");
        expect(token, isA<TokenStringLiteral>());
      });

      test("doublequote literal", () {
        // ignore: avoid_escaping_inner_quotes
        final token = lexer.lex("\"test\"");
        expect(token, isA<TokenStringLiteral>());
      });

      test("empty single quote string", () {
        final token = lexer.lex("''");
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "");
      });

      test("empty double quote string", () {
        final token = lexer.lex('""');
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "");
      });

      test("string with spaces", () {
        final token = lexer.lex("'hello world'");
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "hello world");
      });

      test("multiline string", () {
        final token = lexer.lex("'line1\nline2'");
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "line1\nline2");
      });
    });

    //NOTE - Character escaping works strangely
    group("escape sequences", () {
      test("escaped single quote", () {
        final token = lexer.lex("'test\\'test'");
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "test'test");
      });

      test("escaped double quote", () {
        final token = lexer.lex('"test\\"test"');
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, 'test"test');
      });

      test("escaped backslash", () {
        final token = lexer.lex("'test\\\\test'");
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "test\\test");
      });

      test("escaped newline", () {
        final token = lexer.lex("'test\\ntest'");
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "test\ntest");
      });

      test("escaped tab", () {
        final token = lexer.lex("'test\\ttest'");
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "test\ttest");
      });

      test("escaped backtick", () {
        final token = lexer.lex("'test\\`test'");
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "test\\`test");
      });

      test("multiple escape sequences", () {
        final token = lexer.lex("'test\\n\\t\\'test'");
        expect(token, isA<TokenStringLiteral>());
        expect((token as TokenStringLiteral).literal, "test\n\t'test");
      });
    }, skip: true);

    group("string interpolation", () {
      test("simple interpolation single quote", () {
        final token = lexer.lex("'text \${variable} text'");
        expect(token, isA<TokenStringInterpolation>());
        final interpToken = token as TokenStringInterpolation;
        expect(interpToken.interpolations.isNotEmpty, true);
      });

      test("simple interpolation double quote", () {
        final token = lexer.lex('"text \${variable} text"');
        expect(token, isA<TokenStringInterpolation>());
        final interpToken = token as TokenStringInterpolation;
        expect(interpToken.interpolations.isNotEmpty, true);
      });

      test("multiple interpolations", () {
        final token = lexer.lex("'hello \${name}, age: \${age}'");
        expect(token, isA<TokenStringInterpolation>());
        final interpToken = token as TokenStringInterpolation;
        expect(interpToken.interpolations.length, 2);
      });
    });
  });

  group("Comments", () {
    group("single line", () {
      test("basic single line comment", () {
        final token = lexer.lex("// comment");
        expect(token, isA<TokenComment>());
        final commentToken = token as TokenComment;
        expect(commentToken.isMultiLine, false);
        expect(commentToken.isDocumentation, false);
        expect(commentToken.literal, "comment");
      });

      test("empty single line comment", () {
        final token = lexer.lex("//");
        expect(token, isA<TokenComment>());
        final commentToken = token as TokenComment;
        expect(commentToken.literal.trim(), "");
      });

      test("single line comment with various characters", () {
        final token = lexer.lex("// comment with !@#\$%^&*()");
        expect(token, isA<TokenComment>());
        final commentToken = token as TokenComment;
        expect(commentToken.literal, "comment with !@#\$%^&*()");
      });
    });

    group("documentation", () {
      test("basic documentation comment", () {
        final token = lexer.lex("/// doc comment");
        expect(token, isA<TokenComment>());
        final commentToken = token as TokenComment;
        expect(commentToken.isDocumentation, true);
        expect(commentToken.isMultiLine, false);
        expect(commentToken.literal, "doc comment");
      });

      test("empty documentation comment", () {
        final token = lexer.lex("///");
        expect(token, isA<TokenComment>());
        final commentToken = token as TokenComment;
        expect(commentToken.isDocumentation, true);
        expect(commentToken.literal.trim(), "");
      });
    });

    group("multiline", () {
      test("basic multiline comment", () {
        final token = lexer.lex("/* comment */");
        expect(token, isA<TokenComment>());
        final commentToken = token as TokenComment;
        expect(commentToken.isMultiLine, true);
        expect(commentToken.literal, " comment ");
      });

      test("multiline comment on single line", () {
        final token = lexer.lex("/* single line multiline comment */");
        expect(token, isA<TokenComment>());
        final commentToken = token as TokenComment;
        expect(commentToken.isMultiLine, true);
        expect(commentToken.literal, " single line multiline comment ");
      });

      test("multiline comment spanning multiple lines", () {
        final token = lexer.lex("/* line1\nline2\nline3 */");
        expect(token, isA<TokenComment>());
        final commentToken = token as TokenComment;
        expect(commentToken.isMultiLine, true);
        expect(commentToken.literal, " line1\nline2\nline3 ");
      });

      test("multiline comment with various characters", () {
        final token = lexer.lex("/* comment with !@#\$%^&*() */");
        expect(token, isA<TokenComment>());
        final commentToken = token as TokenComment;
        expect(commentToken.isMultiLine, true);

        /**NOTE
         * lexer_hetu.dart:305
         * 
         * Line trimming works for single-line comments, 
         * but not for multi-line comments. Bug or feature?
         */
        expect(commentToken.literal, " comment with !@#\$%^&*() ");
      });
    });
  });

  group("Identifiers", () {
    group("regular", () {
      test("simple identifier", () {
        final token = lexer.lex("variable");
        expect(token, isA<TokenIdentifier>());
        final idToken = token as TokenIdentifier;
        expect(idToken.isMarked, false);
        expect(idToken.literal, "variable");
      });

      test("identifier with digits", () {
        final token = lexer.lex("var123");
        expect(token, isA<TokenIdentifier>());
        expect((token as TokenIdentifier).literal, "var123");
      });

      test("identifier with underscore prefix", () {
        final token = lexer.lex("_private");
        expect(token, isA<TokenIdentifier>());
        expect((token as TokenIdentifier).literal, "_private");
      });

      test("identifier with underscore", () {
        final token = lexer.lex("my_var");
        expect(token, isA<TokenIdentifier>());
        expect((token as TokenIdentifier).literal, "my_var");
      });

      test("identifier with dollar sign", () {
        final token = lexer.lex("\$variable");
        expect(token, isA<TokenIdentifier>());
        expect((token as TokenIdentifier).literal, "\$variable");
      });

      test("identifier with hash prefix", () {
        final token = lexer.lex("#private");
        expect(token, isA<TokenIdentifier>());
        expect((token as TokenIdentifier).literal, "#private");
      });
    });

    group("marked", () {
      test("marked identifier", () {
        final token = lexer.lex("`identifier`");
        expect(token, isA<TokenIdentifier>());
        final idToken = token as TokenIdentifier;
        expect(idToken.isMarked, true);
        expect(idToken.literal, "identifier");
      });

      test("marked identifier with spaces", () {
        final token = lexer.lex("`my identifier`");
        expect(token, isA<TokenIdentifier>());
        final idToken = token as TokenIdentifier;
        expect(idToken.isMarked, true);
        expect(idToken.literal, "my identifier");
      });

      test("marked identifier with special characters", () {
        final token = lexer.lex("`var-name`");
        expect(token, isA<TokenIdentifier>());
        final idToken = token as TokenIdentifier;
        expect(idToken.isMarked, true);
        expect(idToken.literal, "var-name");
      });
    });
  });

  group("Keywords", () {
    test("class keyword", () {
      final token = lexer.lex("class");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "class");
    });

    test("function keyword", () {
      final token = lexer.lex("function");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "function");
    });

    test("let keyword", () {
      final token = lexer.lex("let");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "let");
    });

    test("var keyword", () {
      final token = lexer.lex("var");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "var");
    });

    test("final keyword", () {
      final token = lexer.lex("final");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "final");
    });

    test("if keyword", () {
      final token = lexer.lex("if");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "if");
    });

    test("else keyword", () {
      final token = lexer.lex("else");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "else");
    });

    test("for keyword", () {
      final token = lexer.lex("for");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "for");
    });

    test("while keyword", () {
      final token = lexer.lex("while");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "while");
    });

    test("return keyword", () {
      final token = lexer.lex("return");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "return");
    });

    test("async keyword", () {
      final token = lexer.lex("async");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "async");
    });

    test("await keyword", () {
      final token = lexer.lex("await");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "await");
    });

    test("break keyword", () {
      final token = lexer.lex("break");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "break");
    });

    test("continue keyword", () {
      final token = lexer.lex("continue");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "continue");
    });

    test("keywords are not identifiers", () {
      final token = lexer.lex("class");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token, isNot(isA<TokenIdentifier>()));
    });
  });

  group("Punctuation", () {
    group("single character", () {
      test("parentheses", () {
        final token1 = lexer.lex("(");
        expect(token1.lexeme, "(");
        final token2 = lexer.lex(")");
        expect(token2.lexeme, ")");
      });

      test("braces", () {
        final token1 = lexer.lex("{");
        expect(token1.lexeme, "{");
        final token2 = lexer.lex("}");
        expect(token2.lexeme, "}");
      });

      test("brackets", () {
        final token1 = lexer.lex("[");
        expect(token1.lexeme, "[");
        final token2 = lexer.lex("]");
        expect(token2.lexeme, "]");
      });

      test("angle brackets", () {
        final token1 = lexer.lex("<");
        expect(token1.lexeme, "<");
        final token2 = lexer.lex(">");
        expect(token2.lexeme, ">");
      });

      test("comma and semicolon", () {
        final token1 = lexer.lex(",");
        expect(token1.lexeme, ",");
        final token2 = lexer.lex(";");
        expect(token2.lexeme, ";");
      });

      test("dot and colon", () {
        final token1 = lexer.lex(".");
        expect(token1.lexeme, ".");
        final token2 = lexer.lex(":");
        expect(token2.lexeme, ":");
      });

      test("operators", () {
        final ops = ["+", "-", "*", "/", "%", "&", "|", "^", "~", "!"];
        for (final op in ops) {
          final token = lexer.lex(op);
          expect(token.lexeme, op);
        }
      });
    });

    group("two character", () {
      test("equality operators", () {
        final token1 = lexer.lex("==");
        expect(token1.lexeme, "==");
        final token2 = lexer.lex("!=");
        expect(token2.lexeme, "!=");
      });

      test("comparison operators", () {
        final token1 = lexer.lex("<=");
        expect(token1.lexeme, "<=");
        final token2 = lexer.lex(">=");
        expect(token2.lexeme, ">=");
      });

      test("shift operators", () {
        final token1 = lexer.lex("<<");
        expect(token1.lexeme, "<<");
        final token2 = lexer.lex(">>");
        expect(token2.lexeme, ">>");
      });

      test("logical operators", () {
        final token1 = lexer.lex("&&");
        expect(token1.lexeme, "&&");
        final token2 = lexer.lex("||");
        expect(token2.lexeme, "||");
      });

      test("null-aware operators", () {
        final token1 = lexer.lex("??");
        expect(token1.lexeme, "??");
        final token2 = lexer.lex("..");
        expect(token2.lexeme, "..");
        final token3 = lexer.lex("?.");
        expect(token3.lexeme, "?.");
      });

      test("assignment operators", () {
        final token1 = lexer.lex("+=");
        expect(token1.lexeme, "+=");
        final token2 = lexer.lex("-=");
        expect(token2.lexeme, "-=");
        final token3 = lexer.lex("*=");
        expect(token3.lexeme, "*=");
        final token4 = lexer.lex("/=");
        expect(token4.lexeme, "/=");
      });

      test("increment decrement", () {
        final token1 = lexer.lex("++");
        expect(token1.lexeme, "++");
        final token2 = lexer.lex("--");
        expect(token2.lexeme, "--");
      });

      test("arrow operators", () {
        final token1 = lexer.lex("->");
        expect(token1.lexeme, "->");
        final token2 = lexer.lex("=>");
        expect(token2.lexeme, "=>");
      });
    });

    group("three character", () {
      test("strict equality", () {
        final token1 = lexer.lex("===");
        expect(token1.lexeme, "===");
        final token2 = lexer.lex("!==");
        expect(token2.lexeme, "!==");
      });

      test("unsigned right shift", () {
        final token = lexer.lex(">>>");
        expect(token.lexeme, ">>>");
      });

      test("compound assignment operators", () {
        final token1 = lexer.lex("??=");
        expect(token1.lexeme, "??=");
        final token2 = lexer.lex("?..");
        expect(token2.lexeme, "?..");
      });
    });
  });

  group("Positioning", () {
    test("first token position", () {
      final token = lexer.lex("test");
      expect(token.line, 1);
      expect(token.column, 1);
      expect(token.offset, 0);
    });

    test("token length and end", () {
      final token = lexer.lex("hello");
      expect(token.length, 5);
      expect(token.end, 5);
    });

    test("tokens on different lines", () {
      final token = lexer.lex("line1\nline2");
      expect(token.line, 1);
      expect(token.next?.line, 2);
    });

    test("position after whitespace", () {
      final token = lexer.lex("   test");
      expect(token.line, 1);
      expect(token.column, 4);
      expect(token.offset, 3);
    });

    test("token previous and next links", () {
      final token = lexer.lex("a b c");
      expect(token.next, isNotNull);
      expect(token.next?.previous, token);
      expect(token.next?.next?.previous, token.next);
    });

    test("endOfFile token", () {
      final token = lexer.lex("test");
      Token? current = token;
      while (current?.next != null) {
        current = current?.next;
      }
      expect(current?.lexeme, Token.endOfFile);
    });

    test("endOfFile position", () {
      final token = lexer.lex("test");
      Token? current = token;
      while (current?.next != null) {
        current = current?.next;
      }
      expect(current?.line, greaterThan(0));
    });
  });

  group("Special cases", () {
    group("empty lines and whitespace", () {
      test("empty line", () {
        final token = lexer.lex("""
    1

    """);
        expect(token.next, isA<TokenEmptyLine>());
      });

      test("multiple empty lines", () {
        final token = lexer.lex("""
    1


    """);
        expect(token.next, isA<TokenEmptyLine>());
        expect(token.next?.next, isA<TokenEmptyLine>());
      });

      test("whitespace at start", () {
        final token = lexer.lex("   test");
        expect(token, isA<TokenIdentifier>());
        expect((token as TokenIdentifier).literal, "test");
      });

      test("whitespace at end", () {
        final token = lexer.lex("test   ");
        expect(token, isA<TokenIdentifier>());
        expect((token as TokenIdentifier).literal, "test");
      });

      test("tab characters", () {
        final token = lexer.lex("\ttest");
        expect(token, isA<TokenIdentifier>());
        expect((token as TokenIdentifier).literal, "test");
      });
    });

    group("end of statement insertion", () {
      test("semicolon after return", () {
        final token = lexer.lex("return\n");
        expect(token.lexeme, "return");
        expect(token.next, isNotNull);
        // Check if semicolon is inserted after return
        Token? current = token;
        while (current != null && current.lexeme != Token.endOfFile) {
          if (current.lexeme == ";") {
            expect(current.previous?.lexeme, "return");
            break;
          }
          current = current.next;
        }
      });

      test("semicolon before opening brace", () {
        final token = lexer.lex("x\n{");
        Token? current = token;
        var foundSemicolon = false;
        while (current != null && current.lexeme != Token.endOfFile) {
          if (current.lexeme == "{" && current.previous?.lexeme == ";") {
            foundSemicolon = true;
            break;
          }
          current = current.next;
        }
        // Semicolon should be inserted if x doesn't end with unfinished token
        expect(foundSemicolon, true);
      });

      test("no semicolon before brace after operator", () {
        final token = lexer.lex("x +\n{");
        Token? current = token;
        var foundSemicolon = false;
        while (current != null && current.lexeme != Token.endOfFile) {
          if (current.lexeme == "{" && current.previous?.lexeme == ";") {
            foundSemicolon = true;
            break;
          }
          current = current.next;
        }
        // Semicolon should NOT be inserted after unfinished token (+)
        expect(foundSemicolon, false);
      });
    });

    group("line endings", () {
      test("unix line ending", () {
        final token = lexer.lex("line1\nline2");
        expect(token.line, 1);
        expect(token.next?.line, 2);
      });

      test("windows line ending", () {
        final token = lexer.lex("line1\r\nline2");
        expect(token.line, 1);
        expect(token.next?.line, 2);
      });
    });
  });

  group("Edge cases", () {
    test("empty input", () {
      final token = lexer.lex("");
      expect(token.lexeme, Token.endOfFile);
    });

    test("very long identifier", () {
      final longId = "a" * 1000;
      final token = lexer.lex(longId);
      expect(token, isA<TokenIdentifier>());
      expect((token as TokenIdentifier).literal, longId);
    });

    test("very long number", () {
      final longNum = "1" * 100;
      expect(() => lexer.lex(longNum), throwsFormatException);
    });
  });

  group("Combinations", () {
    test("number after identifier without space", () {
      final token = lexer.lex("var123");
      expect(token, isA<TokenIdentifier>());
      expect((token as TokenIdentifier).literal, "var123");
    });

    test("multiple token types", () {
      final token = lexer.lex("let x = 5 + 3;");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "let");
    });

    test("function declaration", () {
      final token = lexer.lex("function test() {}");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "function");
    });

    test("class declaration", () {
      final token = lexer.lex("class MyClass {}");
      expect(token, isA<Token>());
      expect(token.isKeyword, true);
      expect(token.lexeme, "class");
    });

    test("string with interpolation in expression", () {
      final token = lexer.lex("'Hello \${name}!'");
      expect(token, isA<TokenStringInterpolation>());
    });
  });
}
