import "package:hetu_script/error/error.dart";
import "package:hetu_script/logger/message_severity.dart";
import "package:hetu_script/analyzer/diagnostic.dart";
import "package:hetu_script/locale/locale.dart";

/// An implementation of [HTError] that used by [HTAnalyzer].
/// The format of the printed error content is different from [HTError].
class HTAnalysisError implements HTError {
  @override
  final HTErrorCode code;

  @override
  String get name => code.toString().split(".").last;

  @override
  final HTErrorType type;

  @override
  MessageSeverity get severity => type.severity;

  late final String _message;

  @override
  String get message => _message;

  @override
  final String? extra;

  @override
  final String? correction;

  @override
  final String filename;

  @override
  final int line;

  @override
  final int column;

  @override
  final int offset;

  @override
  final int length;

  final List<HTDiagnosticMessage> contextMessages;

  HTAnalysisError(
    this.code,
    this.type, {
    required String message,
    required this.filename,
    required this.line,
    required this.column,
    this.extra,
    List<String> interpolations = const [],
    this.correction,
    this.offset = 0,
    this.length = 0,
    this.contextMessages = const [],
  }) {
    for (var i = 0; i < interpolations.length; ++i) {
      message = message.replaceAll("{$i}", interpolations[i].toString());
    }
    _message = message;
  }

  @override
  String toString() {
    final output = StringBuffer();
    output.writeln("$message (at [$filename:$line:$column])");
    return output.toString();
  }

  HTAnalysisError.fromError(
    HTError error, {
    required String filename,
    required int line,
    required int column,
    // int offset = 0,
    // int length = 0,
    List<HTDiagnosticMessage> contextMessages = const [],
  }) : this(
          error.code,
          error.type,
          message: error.message,
          extra: error.extra,
          correction: error.correction,
          filename: filename,
          line: line,
          column: column,
          contextMessages: contextMessages,
        );

  HTAnalysisError.constValue(
    String id, {
    required String filename,
    required int line,
    required int column,
    required int offset,
    required int length,
    String? extra,
    String? correction,
  }) : this(
          HTErrorCode.constValue,
          HTErrorType.staticWarning,
          message: HTLocale.current.errorConstValue,
          extra: extra,
          interpolations: [id],
          correction: correction,
          filename: filename,
          line: line,
          column: column,
          offset: offset,
          length: length,
        );

  HTAnalysisError.importSelf({
    required String filename,
    required int line,
    required int column,
    required int offset,
    required int length,
    String? extra,
    String? correction,
  }) : this(
          HTErrorCode.importSelf,
          HTErrorType.staticWarning,
          message: HTLocale.current.errorImportSelf,
          extra: extra,
          correction: correction,
          filename: filename,
          line: line,
          column: column,
          offset: offset,
          length: length,
        );

  /// Error: Type check failed.
  HTAnalysisError.assignType(
    String id,
    String valueType,
    String declValue, {
    required String filename,
    required int line,
    required int column,
    required int offset,
    required int length,
    String? extra,
    String? correction,
  }) : this(
          HTErrorCode.assignType,
          HTErrorType.staticTypeWarning,
          message: HTLocale.current.errorAssignType,
          interpolations: [id, valueType, declValue],
          extra: extra,
          correction: correction,
          filename: filename,
          line: line,
          column: column,
          offset: offset,
          length: length,
        );
}
