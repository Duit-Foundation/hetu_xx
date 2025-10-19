import "dart:typed_data";

import "package:hetu_script/hetu_script.dart";
import "package:pub_semver/pub_semver.dart";

import "package:hetu_script/value/namespace/namespace.dart";
import "package:hetu_script/bytecode/bytecode_reader.dart";
import "package:hetu_script/constant/global_constant_table.dart";

/// A bytecode module contains the compiled bytes,
/// after the execution of the interpreter, it will also contain namespaces & values.
class HTBytecodeModule extends HTGlobalConstantTable with BytecodeReader {
  /// The version of this module, will be read from the bytes later.
  Version? version;

  /// The compiled time of this module, will be read from the bytes later.
  String? compiledAt;

  /// The name of this module.
  final String id;

  /// An interpreted source is exist as a namespace in bytecode module.
  /// This is empty until interpreter insert the evaled values.
  final Map<String, HTNamespace> namespaces = {};

  /// An interpreted non-source, such as JSON, is exist as a value in bytecode module.
  /// This is empty until interpreter insert the evaled values.
  final Map<String, HTJsonSource> jsonSources = {};

  /// time stamp of the start time of the execution of this module
  int timestamp = 0;

  String? invoke;
  List<dynamic> positionalArgs = const [];
  Map<String, dynamic> namedArgs = const {};

  /// fetch a contant value defined within any namespace of this module.
  String getConstString() {
    final index = readUint16();
    return getGlobalConstant(String, index);
  }

  HTBytecodeModule({
    required this.id,
    required Uint8List bytes,
  }) {
    this.bytes = bytes;
  }

  void init({
    String? invoke,
    List<dynamic> positionalArgs = const [],
    Map<String, dynamic> namedArgs = const {},
  }) {
    timestamp = DateTime.now().millisecondsSinceEpoch;
    ip = 0;
    this.invoke = invoke;
    this.positionalArgs = positionalArgs;
    this.namedArgs = namedArgs;
  }
}
