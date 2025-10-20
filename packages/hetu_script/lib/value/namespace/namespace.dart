import "package:hetu_script/declaration/index.dart";
import "package:hetu_script/error/index.dart";
import "package:hetu_script/type/index.dart";
import "package:hetu_script/value/index.dart";
import "package:hetu_script/common/index.dart";

/// A namespace that will return the actual value of the declaration.
class HTNamespace extends HTDeclarationNamespace<dynamic> {
  @override
  HTType? get valueType => HTTypeNamespace(lexicon.kNamespace);

  final HTNamespace? _closure;

  @override
  HTNamespace? get closure => _closure;

  HTNamespace({
    required super.lexicon,
    super.id,
    super.classId,
    HTNamespace? closure,
    super.source,
    super.documentation,
    super.isPrivate,
  })  : _closure = closure,
        super(closure: closure);

  // String? help(String id) {
  //   if (symbols.containsKey(id)) {
  //     final decl = symbols[id]!;
  //     return decl.documentation;
  //   } else if (importedSymbols.containsKey(id)) {
  //     final decl = importedSymbols[id]!;
  //     return decl.documentation;
  //   } else if (closure != null) {
  //     final decl =
  //         closure!.memberGet(id, isRecursive: true, ignoreUndefined: false);
  //     if (decl != null) {
  //       return (decl as HTDeclaration).documentation;
  //     }
  //   }
  //   throw HTError.undefined(id);
  // }

  @override
  dynamic memberGet(
    String id, {
    String? from,
    bool isRecursive = false,
    bool isPrivate = false,
    bool ignoreUndefined = false,
    bool asDeclaration = false,
  }) {
    if (id == InternalIdentifier.name) {
      return fullName;
    }

    if (symbols.containsKey(id)) {
      final decl = symbols[id]!;
      if (asDeclaration) return decl;
      if (decl is HTDeclaration) {
        if (decl.isPrivate && from != null && !from.startsWith(fullName)) {
          throw HTError.privateMember(id);
        }
        decl.resolve();
        return decl.value;
      } else {
        return decl;
      }
    } else if (importedSymbols.containsKey(id)) {
      final decl = importedSymbols[id]!;
      if (decl is HTDeclaration) {
        if (asDeclaration) return decl;
        if (decl.isPrivate && from != null && !from.startsWith(fullName)) {
          throw HTError.privateMember(id);
        }
        decl.resolve();
        return decl.value;
      } else {
        return decl;
      }
    } else if (isRecursive && (closure != null)) {
      return closure!.memberGet(
        id,
        from: from,
        isRecursive: isRecursive,
        ignoreUndefined: ignoreUndefined,
        asDeclaration: asDeclaration,
      );
    }

    if (id == lexicon.idKeys) {
      return symbols.keys;
    } else if (id == lexicon.idValues) {
      return symbols.values;
    }

    if (!ignoreUndefined) {
      throw HTError.undefined(id);
    }
  }

  /// Fetch a declaration from this namespace,
  /// if not found and [isRecursive] is true, will continue search in super namespaces,
  /// then assign the value to that declaration.
  /// If [isRecursive] is true, means this is not a 'memberset operator' search.
  @override
  bool memberSet(
    String id,
    value, {
    String? from,
    bool defineIfAbsent = false,
    bool isRecursive = false,
    bool ignoreUndefined = false,
  }) {
    if (symbols.containsKey(id)) {
      final decl = symbols[id]!;
      if (decl.isPrivate && from != null && !from.startsWith(fullName)) {
        throw HTError.privateMember(id);
      }
      decl.resolve();
      decl.value = value;
      return true;
    } else if (importedSymbols.containsKey(id)) {
      final decl = importedSymbols[id]!;
      if (decl.isPrivate && from != null && !from.startsWith(fullName)) {
        throw HTError.privateMember(id);
      }
      decl.resolve();
      decl.value = value;
      return true;
    } else if (isRecursive && (closure != null)) {
      return closure!.memberSet(
        id,
        value,
        from: from,
        isRecursive: true,
        ignoreUndefined: ignoreUndefined,
      );
    } else {
      if (defineIfAbsent) {
        symbols[id] = value;
      } else if (!ignoreUndefined) {
        throw HTError.undefined(id);
      }
    }

    return false;
  }

  @override
  HTDeclarationNamespace<HTDeclaration> clone() {
    final cloned = HTDeclarationNamespace<HTDeclaration>(
      lexicon: lexicon,
      id: id,
      classId: classId,
      closure: closure,
      source: source,
    );
    for (final decl in symbols.values) {
      cloned.symbols[decl.id!] = decl.clone();
    }
    for (final decl in imports.values) {
      cloned.imports[decl.fromPath] = decl;
    }
    cloned.exports.addAll(exports);
    for (final decl in importedSymbols.values) {
      cloned.importedSymbols[decl.id!] = decl.clone();
    }
    return cloned;
  }

  String help({bool displayNamespaceName = true}) {
    final buffer = StringBuffer();
    final id = displayNamespaceName ? fullName : "";
    if (symbols.isNotEmpty || importedSymbols.isNotEmpty) {
      buffer.writeln("namespace $id {");
      for (final decl in symbols.values) {
        if (decl is HTFunction) {
          buffer.writeln("  ${decl.internalName}");
        } else {
          buffer.writeln("  ${decl.id}");
        }
      }
      for (final decl in importedSymbols.values) {
        if (decl is HTFunction) {
          buffer.writeln("  ${decl.internalName}");
        } else {
          buffer.writeln("  ${decl.id}");
        }
      }
      buffer.writeln("}");
    } else {
      buffer.writeln("namespace $id {}");
    }
    return buffer.toString();
  }
}
