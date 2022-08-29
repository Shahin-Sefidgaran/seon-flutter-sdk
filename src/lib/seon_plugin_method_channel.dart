import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'seon_plugin_platform_interface.dart';

/// An implementation of [SeonPluginPlatform] that uses method channels.
class MethodChannelSeonPlugin extends SeonPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('seon_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
