#import "SeonPlugin.h"
#if __has_include(<seon_plugin/seon_plugin-Swift.h>)
#import <seon_plugin/seon_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "seon_plugin-Swift.h"
#endif

@implementation SeonPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSeonPlugin registerWithRegistrar:registrar];
}
@end
