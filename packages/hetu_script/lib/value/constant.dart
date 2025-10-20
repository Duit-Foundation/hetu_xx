import "package:hetu_script/constant/global_constant_table.dart";
import "package:hetu_script/declaration/declaration.dart";

class HTConstantValue extends HTDeclaration {
  @override
  bool get isConst => true;

  final int index;

  final Type type;

  final HTGlobalConstantTable globalConstantTable;

  HTConstantValue({
    required String id,
    required this.type,
    required this.index,
    required this.globalConstantTable,
    super.classId,
    super.documentation,
    super.isTopLevel = false,
    super.isPrivate,
  }) : super(id: id);

  @override
  void resolve() {}

  @override
  dynamic get value => globalConstantTable.getGlobalConstant(type, index);

  @override
  HTConstantValue clone() => this;
}
