import "package:meta/meta.dart";

import "package:hetu_xx/type/index.dart";
import "package:hetu_xx/declaration/index.dart";
import "package:hetu_xx/common/index.dart";

class HTFunctionDeclaration extends HTDeclaration
    implements HasGenericTypeParameter {
  final String internalName;

  final FunctionCategory category;

  final String? externalTypeId;

  /// Wether this declaration is within a explicity namespace declaration.
  final String? explicityNamespaceId;

  @override
  final List<HTGenericTypeParameter> genericTypeParameters;

  /// Wether to check params when called
  /// A function like:
  ///   ```
  ///     function { return 42 }
  ///   ```
  /// will accept any params, while a function:
  ///   ```
  ///     function () { return 42 }
  ///   ```
  /// will accept 0 params
  final bool hasParamDecls;

  /// Holds declarations of all parameters.
  final Map<String, HTAbstractParameter> paramDecls;

  HTType? get returnType => declType.returnType;

  final HTFunctionType _declType;

  HTFunctionType? _resolvedDeclType;

  @override
  HTFunctionType get declType => _resolvedDeclType ?? _declType;

  final bool isAsync;

  // bool get isField =>
  //     category != FunctionCategory.normal &&
  //     category != FunctionCategory.literal;

  final bool isAbstract;

  final bool isVariadic;

  final int minArity;

  final int maxArity;

  bool _isResolved = false;
  @override
  bool get isResolved => _isResolved;

  HTFunctionDeclaration({
    required this.internalName,
    super.id,
    super.classId,
    this.explicityNamespaceId,
    super.closure,
    super.source,
    super.documentation,
    super.isPrivate,
    super.isExternal,
    super.isStatic,
    super.isConst,
    super.isTopLevel,
    super.isField,
    this.category = FunctionCategory.normal,
    this.externalTypeId,
    this.genericTypeParameters = const [],
    this.hasParamDecls = true,
    this.paramDecls = const {},
    HTFunctionType? declType,
    this.isAsync = false,
    this.isAbstract = false,
    this.isVariadic = false,
    this.minArity = 0,
    this.maxArity = 0,
  }) : _declType = declType ?? HTFunctionType();

  @override
  @mustCallSuper
  void resolve({bool resolveType = true}) {
    if (_isResolved) {
      return;
    }
    for (final param in paramDecls.values) {
      param.resolve();
    }
    if (resolveType && closure != null) {
      _resolvedDeclType = _declType.resolve(closure!) as HTFunctionType;
    }
    _isResolved = true;
  }

  @override
  HTFunctionDeclaration clone() => HTFunctionDeclaration(
        internalName: internalName,
        id: id,
        classId: classId,
        closure: closure,
        source: source,
        isExternal: isExternal,
        isStatic: isStatic,
        isConst: isConst,
        isTopLevel: isTopLevel,
        category: category,
        externalTypeId: externalTypeId,
        genericTypeParameters: genericTypeParameters,
        paramDecls: paramDecls,
        declType: declType,
        isField: isField,
        isAbstract: isAbstract,
        isVariadic: isVariadic,
        minArity: minArity,
        maxArity: maxArity,
      );
}
