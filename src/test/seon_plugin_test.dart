import 'package:flutter_test/flutter_test.dart';
import 'package:seon_plugin/seon_plugin.dart';
import 'package:seon_plugin/seon_plugin_platform_interface.dart';
import 'package:seon_plugin/seon_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSeonPluginPlatform 
    with MockPlatformInterfaceMixin
    implements SeonPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SeonPluginPlatform initialPlatform = SeonPluginPlatform.instance;

  test('$MethodChannelSeonPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSeonPlugin>());
  });

  test('getPlatformVersion', () async {
    SeonPlugin seonPlugin = SeonPlugin();
    MockSeonPluginPlatform fakePlatform = MockSeonPluginPlatform();
    SeonPluginPlatform.instance = fakePlatform;
  
    expect(await seonPlugin.getPlatformVersion(), '42');
  });
}
