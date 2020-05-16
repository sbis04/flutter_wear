#import "FlutterWearPlugin.h"
#if __has_include(<flutter_wear/flutter_wear-Swift.h>)
#import <flutter_wear/flutter_wear-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_wear-Swift.h"
#endif

@implementation FlutterWearPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterWearPlugin registerWithRegistrar:registrar];
}
@end
