import "package:hetu_xx/ast/index.dart";
import "package:hetu_xx/resource/index.dart";
import "package:hetu_xx/source/index.dart";
import "package:hetu_xx/error/index.dart";
import "package:hetu_xx/analyzer/index.dart";
import "package:hetu_xx/bundler/index.dart";
import "package:hetu_xx/parser/index.dart";

class HTAnalysisManager {
  final HTErrorHandlerCallback? errorHandler;

  /// The underlying context manager for analyzer to access to source.
  final HTSourceManager<HTSource, HTResourceContext<HTSource>>
      sourceContextManager;

  final _pathsToAnalyzer = <String, HTAnalyzer>{};

  final _cachedSourceAnalysisResults = <String, HTSourceAnalysisResult>{};

  Iterable<String> get pathsToAnalyze => _pathsToAnalyzer.keys;

  HTAnalysisManager(this.sourceContextManager, {this.errorHandler}) {
    sourceContextManager.onRootsUpdated = () {
      for (final context in sourceContextManager.contexts) {
        final analyzer = HTAnalyzer(sourceContext: context);
        for (final path in context.included) {
          _pathsToAnalyzer[path] = analyzer;
        }
      }
    };
  }

  ASTSource? getParseResult(String fullName) =>
      _cachedSourceAnalysisResults[fullName]!.parseResult;

  HTSourceAnalysisResult analyze(String fullName) {
    // final normalized = HTResourceContext.getAbsolutePath(key: fullName);
    final analyzer = _pathsToAnalyzer[fullName]!;
    final source = sourceContextManager.getResource(fullName)!;
    final parser = HTParserHetu();
    final bundler =
        HTBundler(sourceContext: analyzer.sourceContext, parser: parser);
    final compilation = bundler.bundle(source: source);
    final result = analyzer.analyzeCompilation(compilation);
    _cachedSourceAnalysisResults.addAll(result.sourceAnalysisResults);
    return result.sourceAnalysisResults.values.last;
  }
}
