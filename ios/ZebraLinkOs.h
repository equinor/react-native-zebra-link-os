
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNZebraLinkOsSpec.h"

@interface ZebraLinkOs : NSObject <NativeZebraLinkOsSpec>
#else
#import <React/RCTBridgeModule.h>

@interface ZebraLinkOs : NSObject <RCTBridgeModule>
#endif

@end
