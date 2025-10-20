import "package:hetu_script/error/index.dart";
import "package:hetu_script/external/external_class.dart";
import "package:hetu_script/interpreter/interpreter.dart";
import "package:hetu_script/type/external.dart";
import "package:hetu_script/type/nominal.dart";
import "package:hetu_script/type/type.dart";
import "package:hetu_script/value/class/class.dart";
import "package:hetu_script/value/function/function.dart";
import "package:hetu_script/value/object.dart";

/// Class for external object.
class HTExternalInstance<T> with HTObject, InterpreterRef {
  @override
  late final HTType valueType;

  /// the external object.
  final T externalObject;
  final String typeString;
  late final HTExternalClass? externalClass;

  HTClass? klass;

  // HTExternalEnum? enumClass;

  /// Create a external class object.
  HTExternalInstance(
    this.externalObject,
    HTInterpreter interpreter,
    this.typeString,
  ) {
    this.interpreter = interpreter;
    final id = interpreter.lexicon.getBaseTypeId(typeString);
    if (interpreter.containsExternalClass(id)) {
      externalClass = interpreter.fetchExternalClass(id);
    } else {
      externalClass = null;
    }

    klass = interpreter.currentNamespace
        .memberGet(id, isRecursive: true, ignoreUndefined: true);
    // else if (def is HTExternalEnum) {
    //   enumClass = def;
    // }
    if (klass != null) {
      valueType = HTNominalType(klass: klass!);
    } else {
      valueType = HTExternalType(typeString);
    }
  }

  @override
  dynamic memberGet(
    String id, {
    String? from,
    bool isRecursive = false,
    bool ignoreUndefined = false,
  }) {
    if (externalClass != null) {
      dynamic member = externalClass!.instanceMemberGet(externalObject, id);
      if (member is Function) {
        HTClass? currentKlass = klass!;
        HTFunction? decl;
        while (decl == null && currentKlass != null) {
          decl = currentKlass.memberGet(id, ignoreUndefined: true);
          currentKlass = currentKlass.superClass;
        }
        assert(
          decl != null,
          "Could not find hetu declaration on external id: $typeString.$id",
        );
        decl = decl!.clone();
        // Assign the value as if we are doing decl.resolve() here.
        decl.externalFunc = member;
        decl.instance = externalObject;
        return decl;
      } else {
        return member;
      }
    }
    if (!ignoreUndefined) {
      throw HTError.undefined(id);
    }
  }

  @override
  void memberSet(
    String id,
    value, {
    String? from,
    bool defineIfAbsent = false,
  }) {
    if (externalClass != null) {
      externalClass!.instanceMemberSet(externalObject, id, value);
    } else {
      throw HTError.unknownExternalTypeName(typeString);
    }
  }

  String help() {
    final buffer = StringBuffer();
    buffer.writeln("external object: $typeString");
    if (klass != null) {
      buffer.write(klass!.help());
    }
    return buffer.toString();
  }
}
