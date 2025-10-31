import "package:hetu_xx/declaration/index.dart";
import "package:hetu_xx/external/index.dart";
import "package:hetu_xx/interpreter/index.dart";
import "package:hetu_xx/value/index.dart";

class HTExternalEnum extends HTDeclaration with HTObject, InterpreterRef {
  HTExternalClass? externalClass;

  bool get isNested => classId != null;

  bool _isResolved = false;
  @override
  bool get isResolved => _isResolved;

  HTExternalEnum(
    HTInterpreter interpreter, {
    required String id,
    super.documentation,
  }) : super(
          id: id,
          isExternal: true,
          isTopLevel: true,
        ) {
    this.interpreter = interpreter;
  }

  @override
  dynamic memberGet(
    String id, {
    String? from,
    bool isRecursive = false,
    bool ignoreUndefined = false,
  }) {
    final item = externalClass!
        .memberGet(id, from: from, ignoreUndefined: ignoreUndefined);
    return item;
  }

  @override
  void resolve() {
    if (_isResolved) return;
    super.resolve();
    externalClass = interpreter.fetchExternalClass(id!);
    _isResolved = true;
  }

  @override
  HTExternalEnum clone() => HTExternalEnum(interpreter, id: id!);
}
