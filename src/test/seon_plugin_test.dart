import 'package:flutter_test/flutter_test.dart';
import 'package:seon_plugin/seon_plugin_platform_interface.dart';
import 'package:seon_plugin/seon_plugin_method_channel.dart';

void main() {
  final SeonPluginPlatform initialPlatform = SeonPluginPlatform.instance;

  test('$MethodChannelSeonPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSeonPlugin>());
  });
}
