import 'seon_plugin_platform_interface.dart';

class SeonPlugin {
  Future<String?> getFingerPrintBase64(
          {required String? sessionId, required bool isLoggingEnabled}) =>
      SeonPluginPlatform.instance
          .getFingerPrintBase64(sessionId, isLoggingEnabled);
}
