
import 'seon_plugin_platform_interface.dart';

class SeonPlugin {
  Future<String?> getPlatformVersion() {
    return SeonPluginPlatform.instance.getPlatformVersion();
  }
}
