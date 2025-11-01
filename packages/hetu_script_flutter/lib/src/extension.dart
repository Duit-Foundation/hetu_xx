import 'package:hetu_xx/hetu_xx.dart';

import 'assets_resource_context.dart';

extension HTFlutterExtension on Hetu {
  Future<void> initFlutter({
    bool useDefaultModuleAndBinding = true,
    Map<String, Function> externalFunctions = const {},
    Map<String, Function Function(HTFunction)> externalFunctionTypedef =
        const {},
    List<HTExternalClass> externalClasses = const [],
  }) async {
    if (sourceContext is HTAssetResourceContext) {
      await (sourceContext as HTAssetResourceContext).init();
    }
    init(
        useDefaultModuleAndBinding: useDefaultModuleAndBinding,
        externalFunctions: externalFunctions,
        externalFunctionTypedef: externalFunctionTypedef,
        externalClasses: externalClasses);
  }
}
