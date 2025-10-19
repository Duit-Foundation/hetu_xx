import "package:hetu_script/ast/abstract_ast_visitor.dart";
import "package:hetu_script/ast/ast.dart";

/// An AST visitor that will recursively visit all of the sub nodes in an AST
/// structure. For example, using an instance of this class to visit a [Block]
/// will also cause all of the statements in the node to be visited.
///
/// Subclasses that override a visit method must either invoke the overridden
/// visit method or must explicitly ask the visited node to visit its children.
/// Otherwise the children of the visited node might not be visited.
abstract class RecursiveASTVisitor implements AbstractASTVisitor<void> {
  @override
  void visitCompilation(ASTCompilation node) => node.subAccept(this);

  @override
  void visitSource(ASTSource node) {
    node.subAccept(this);
  }

  @override
  void visitComment(ASTComment node) {
    node.subAccept(this);
  }

  @override
  void visitEmptyLine(ASTEmptyLine node) {
    node.subAccept(this);
  }

  @override
  void visitEmptyExpr(ASTEmpty node) {
    node.subAccept(this);
  }

  @override
  void visitNullExpr(ASTLiteralNull node) {
    node.subAccept(this);
  }

  @override
  void visitBooleanExpr(ASTLiteralBoolean node) {
    node.subAccept(this);
  }

  @override
  void visitIntLiteralExpr(ASTLiteralInteger node) {
    node.subAccept(this);
  }

  @override
  void visitFloatLiteralExpr(ASTLiteralFloat node) {
    node.subAccept(this);
  }

  @override
  void visitStringLiteralExpr(ASTLiteralString node) {
    node.subAccept(this);
  }

  @override
  void visitStringInterpolationExpr(ASTStringInterpolation node) {
    node.subAccept(this);
  }

  @override
  void visitIdentifierExpr(IdentifierExpr node) {
    node.subAccept(this);
  }

  @override
  void visitSpreadExpr(SpreadExpr node) {
    node.subAccept(this);
  }

  @override
  void visitCommaExpr(ParallelExpr node) {
    node.subAccept(this);
  }

  @override
  void visitListExpr(ListExpr node) {
    node.subAccept(this);
  }

  @override
  void visitInOfExpr(InOfExpr node) {
    node.subAccept(this);
  }

  @override
  void visitGroupExpr(GroupExpr node) {
    node.subAccept(this);
  }

  @override
  void visitIntrinsicTypeExpr(IntrinsicTypeExpr node) {
    node.subAccept(this);
  }

  @override
  void visitNominalTypeExpr(NominalTypeExpr node) {
    node.subAccept(this);
  }

  @override
  void visitParamTypeExpr(ParamTypeExpr node) {
    node.subAccept(this);
  }

  @override
  void visitFunctionTypeExpr(FuncTypeExpr node) {
    node.subAccept(this);
  }

  @override
  void visitFieldTypeExpr(FieldTypeExpr node) {
    node.subAccept(this);
  }

  @override
  void visitStructuralTypeExpr(StructuralTypeExpr node) {
    node.subAccept(this);
  }

  @override
  void visitGenericTypeParamExpr(GenericTypeParameterExpr node) {
    node.subAccept(this);
  }

  @override
  void visitUnaryPrefixExpr(UnaryPrefixExpr node) {
    node.subAccept(this);
  }

  @override
  void visitUnaryPostfixExpr(UnaryPostfixExpr node) {
    node.subAccept(this);
  }

  @override
  void visitBinaryExpr(BinaryExpr node) {
    node.subAccept(this);
  }

  @override
  void visitTernaryExpr(TernaryExpr node) {
    node.subAccept(this);
  }

  @override
  void visitAssignExpr(AssignExpr node) {
    node.subAccept(this);
  }

  @override
  void visitMemberExpr(MemberExpr node) {
    node.subAccept(this);
  }

  @override
  void visitSubExpr(SubExpr node) {
    node.subAccept(this);
  }

  @override
  void visitCallExpr(CallExpr node) {
    node.subAccept(this);
  }

  @override
  void visitAssertStmt(AssertStmt node) {
    node.subAccept(this);
  }

  @override
  void visitThrowStmt(ThrowStmt node) {
    node.subAccept(this);
  }

  @override
  void visitExprStmt(ExprStmt node) {
    node.subAccept(this);
  }

  @override
  void visitBlockStmt(BlockStmt node) {
    node.subAccept(this);
  }

  @override
  void visitReturnStmt(ReturnStmt node) {
    node.subAccept(this);
  }

  @override
  void visitIf(IfExpr node) {
    node.subAccept(this);
  }

  @override
  void visitWhileStmt(WhileStmt node) {
    node.subAccept(this);
  }

  @override
  void visitDoStmt(DoStmt node) {
    node.subAccept(this);
  }

  @override
  void visitForStmt(ForExpr node) {
    node.subAccept(this);
  }

  @override
  void visitForRangeStmt(ForRangeExpr node) {
    node.subAccept(this);
  }

  @override
  void visitSwitch(SwitchStmt node) {
    node.subAccept(this);
  }

  @override
  void visitBreakStmt(BreakStmt node) {
    node.subAccept(this);
  }

  @override
  void visitContinueStmt(ContinueStmt node) {
    node.subAccept(this);
  }

  @override
  void visitDeleteStmt(DeleteStmt node) {
    node.subAccept(this);
  }

  @override
  void visitDeleteMemberStmt(DeleteMemberStmt node) {
    node.subAccept(this);
  }

  @override
  void visitDeleteSubStmt(DeleteSubStmt node) {
    node.subAccept(this);
  }

  @override
  void visitImportExportDecl(ImportExportDecl node) {
    node.subAccept(this);
  }

  @override
  void visitNamespaceDecl(NamespaceDecl node) {
    node.subAccept(this);
  }

  @override
  void visitTypeAliasDecl(TypeAliasDecl node) {
    node.subAccept(this);
  }

  @override
  void visitVarDecl(VarDecl node) {
    node.subAccept(this);
  }

  @override
  void visitDestructuringDecl(DestructuringDecl node) {
    node.subAccept(this);
  }

  @override
  void visitParamDecl(ParamDecl node) {
    node.subAccept(this);
  }

  @override
  void visitReferConstructCallExpr(RedirectingConstructorCallExpr node) {
    node.subAccept(this);
  }

  @override
  void visitFuncDecl(FuncDecl node) {
    node.subAccept(this);
  }

  @override
  void visitClassDecl(ClassDecl node) {
    node.subAccept(this);
  }

  @override
  void visitEnumDecl(EnumDecl node) {
    node.subAccept(this);
  }

  @override
  void visitStructDecl(StructDecl node) {
    node.subAccept(this);
  }

  @override
  void visitStructObjField(StructObjField node) {
    node.subAccept(this);
  }

  @override
  void visitStructObjExpr(StructObjExpr node) {
    node.subAccept(this);
  }
}
