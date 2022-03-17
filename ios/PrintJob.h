#import <Foundation/Foundation.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTUtils.h>
#import <React/RCTImageLoader.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^Block)(NSString *message);

@interface PrintJob : NSObject {
    Block resolve;
    Block reject;
}

@property (copy, atomic) NSString* printerSerialNumber;

@property (copy, atomic) NSString* location;
@property (copy, atomic) NSString* whs;
@property (copy, atomic) NSString* description;
@property (copy, atomic) NSString* material;
@property (copy, atomic) NSString* equipNo;
@property (copy, atomic) NSString* partNo;
@property (copy, atomic) NSString* serialNo;
@property (copy, atomic) NSString* qrString;
@property (copy, atomic) NSString* grDate;

@property(readwrite, copy) Block resolve;
@property(readwrite, copy) Block reject;






@end



NS_ASSUME_NONNULL_END
