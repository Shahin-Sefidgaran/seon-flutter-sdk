import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'seon_plugin_platform_interface.dart';

/// An implementation of [SeonPluginPlatform] that uses method channels.
class MethodChannelSeonPlugin extends SeonPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('seon_plugin');

  @override
  Future<String?> getFingerPrintBase64(
      String? sessionId, bool isLoggingEnabled) async {
    final String? result = await methodChannel.invokeMethod('getFingerPrint',
        {"sessionId": sessionId, "isLoggingEnabled": isLoggingEnabled});

    return result;
  }
}
