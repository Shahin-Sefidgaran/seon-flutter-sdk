import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seon_plugin/seon_plugin_method_channel.dart';

void main() {
  MethodChannelSeonPlugin platform = MethodChannelSeonPlugin();
  const MethodChannel channel = MethodChannel('seon_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
