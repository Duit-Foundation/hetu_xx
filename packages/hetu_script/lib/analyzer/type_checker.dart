import "package:hetu_script/ast/index.dart";
import "package:hetu_script/type/index.dart";
import "package:hetu_script/lexicon/index.dart";

/// A interpreter that compute [HTType] out of [ASTNode]
class HTTypeChecker implements AbstractASTVisitor<HTType> {
  final HTLexicon _lexicon;

  HTTypeChecker({HTLexicon? lexicon}) : _lexicon = lexicon ?? HTLexiconHetu();

  HTType evalAstNode(ASTNode node) => node.accept(this);

  @override
  HTType visitCompilation(ASTCompilation node) {
    throw "Don't use this on AstCompilation.";
  }

  @override
  HTType visitSource(ASTSource node) {
    throw "Don't use this on AstSource.";
  }

  @override
  HTType visitComment(ASTComment node) {
    throw "Not a value";
  }

  @override
  HTType visitEmptyLine(ASTEmptyLine node) {
    throw "Not a value";
  }

  @override
  HTType visitEmptyExpr(ASTEmpty node) {
    throw "Not a value";
  }

  @override
  HTType visitNullExpr(ASTLiteralNull node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitBooleanExpr(ASTLiteralBoolean node) => HTNominalType(id: "bool");

  @override
  HTType visitIntLiteralExpr(ASTLiteralInteger node) =>
      HTNominalType(id: "int");

  @override
  HTType visitFloatLiteralExpr(ASTLiteralFloat node) =>
      HTNominalType(id: "float");

  @override
  HTType visitStringLiteralExpr(ASTLiteralString node) =>
      HTNominalType(id: "string");

  @override
  HTType visitStringInterpolationExpr(ASTStringInterpolation node) =>
      HTNominalType(id: "string");

  @override
  HTType visitIdentifierExpr(IdentifierExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitSpreadExpr(SpreadExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitCommaExpr(ParallelExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitListExpr(ListExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitInOfExpr(InOfExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitGroupExpr(GroupExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitIntrinsicTypeExpr(IntrinsicTypeExpr node) =>
      HTTypeAny(_lexicon.kAny);

  @override
  HTType visitNominalTypeExpr(NominalTypeExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitParamTypeExpr(ParamTypeExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitFunctionTypeExpr(FuncTypeExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitFieldTypeExpr(FieldTypeExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitStructuralTypeExpr(StructuralTypeExpr node) =>
      HTTypeAny(_lexicon.kAny);

  @override
  HTType visitGenericTypeParamExpr(GenericTypeParameterExpr node) =>
      HTTypeAny(_lexicon.kAny);

  /// -e, !e，++e, --e
  @override
  HTType visitUnaryPrefixExpr(UnaryPrefixExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitUnaryPostfixExpr(UnaryPostfixExpr node) =>
      HTTypeAny(_lexicon.kAny);

  /// *, /, ~/, %, +, -, <, >, <=, >=, ==, !=, &&, ||
  @override
  HTType visitBinaryExpr(BinaryExpr node) => HTTypeAny(_lexicon.kAny);

  /// e1 ? e2 : e3
  @override
  HTType visitTernaryExpr(TernaryExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitAssignExpr(AssignExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitMemberExpr(MemberExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitSubExpr(SubExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitCallExpr(CallExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitAssertStmt(AssertStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitThrowStmt(ThrowStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitExprStmt(ExprStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitBlockStmt(BlockStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitReturnStmt(ReturnStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitIf(IfExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitWhileStmt(WhileStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitDoStmt(DoStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitForStmt(ForExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitForRangeStmt(ForRangeExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitSwitch(SwitchStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitBreakStmt(BreakStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitContinueStmt(ContinueStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitDeleteStmt(DeleteStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitDeleteMemberStmt(DeleteMemberStmt node) =>
      HTTypeAny(_lexicon.kAny);

  @override
  HTType visitDeleteSubStmt(DeleteSubStmt node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitImportExportDecl(ImportExportDecl node) =>
      HTTypeAny(_lexicon.kAny);

  @override
  HTType visitNamespaceDecl(NamespaceDecl node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitTypeAliasDecl(TypeAliasDecl node) => HTTypeAny(_lexicon.kAny);

  // @override
  // HTType visitConstDecl(ConstDecl node) {
  //
  // return HTTypeAny(_lexicon.typeAny);
  // }

  @override
  HTType visitVarDecl(VarDecl node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitDestructuringDecl(DestructuringDecl node) =>
      HTTypeAny(_lexicon.kAny);

  @override
  HTType visitParamDecl(ParamDecl node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitReferConstructCallExpr(RedirectingConstructorCallExpr node) =>
      HTTypeAny(_lexicon.kAny);

  @override
  HTType visitFuncDecl(FuncDecl node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitClassDecl(ClassDecl node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitEnumDecl(EnumDecl node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitStructDecl(StructDecl node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitStructObjExpr(StructObjExpr node) => HTTypeAny(_lexicon.kAny);

  @override
  HTType visitStructObjField(StructObjField node) => HTTypeAny(_lexicon.kAny);
}
