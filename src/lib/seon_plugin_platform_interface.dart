import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'seon_plugin_method_channel.dart';

abstract class SeonPluginPlatform extends PlatformInterface {
  /// Constructs a SeonPluginPlatform.
  SeonPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SeonPluginPlatform _instance = MethodChannelSeonPlugin();

  /// The default instance of [SeonPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelSeonPlugin].
  static SeonPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SeonPluginPlatform] when
  /// they register themselves.
  static set instance(SeonPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getFingerPrintBase64(
          String? sessionId, bool isLoggingEnabled) =>
      _instance.getFingerPrintBase64(sessionId, isLoggingEnabled);
}
