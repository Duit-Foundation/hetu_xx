import "package:hetu_xx/declaration/index.dart";

class HTParameterDeclaration extends HTVariableDeclaration
    implements HTAbstractParameter {
  @override
  final bool isOptional;

  @override
  final bool isNamed;

  @override
  final bool isVariadic;

  @override
  final bool isInitialization;

  /// Create a standard [HTParameter].
  HTParameterDeclaration({
    required super.id,
    super.closure,
    super.source,
    super.declType,
    this.isVariadic = false,
    this.isOptional = false,
    this.isNamed = false,
    this.isInitialization = false,
  }) : super(isMutable: true);

  @override
  void initialize() {}

  @override
  HTParameterDeclaration clone() => HTParameterDeclaration(
        id: id!,
        closure: closure,
        declType: declType,
        isVariadic: isVariadic,
        isOptional: isOptional,
        isNamed: isNamed,
        isInitialization: isInitialization,
      );
}
