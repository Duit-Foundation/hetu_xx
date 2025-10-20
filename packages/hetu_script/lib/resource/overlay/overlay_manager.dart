import "package:hetu_script/resource/resource_manager.dart";
import "package:hetu_script/source/source.dart";
import "package:hetu_script/resource/overlay/overlay_context.dart";

class HTOverlayContextManager
    extends HTSourceManager<HTSource, HTOverlayContext> {
  @override
  bool get isSearchEnabled => false;

  @override
  HTOverlayContext createContext(String root) =>
      HTOverlayContext(root: root, cache: cachedSources);
}
