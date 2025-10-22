import "package:hetu_script/resource/index.dart";
import "package:hetu_script/source/index.dart";

class HTOverlayContextManager
    extends HTSourceManager<HTSource, HTOverlayContext> {
  @override
  bool get isSearchEnabled => false;

  @override
  HTOverlayContext createContext(String root) =>
      HTOverlayContext(root: root, cache: cachedSources);
}
