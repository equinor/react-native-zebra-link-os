#import <Foundation/Foundation.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTUtils.h>
#import <React/RCTImageLoader.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelHelper : NSObject
+ (UIImage *) createLabelImage: (NSString*) location
                           whs:(NSString*) whs
                   description:(NSString*) description
                      material:(NSString*) material
                       equipNo:(NSString*) equipNo
                        partNo:(NSString*) partNo
                      serialNo:(NSString*) serialNo
                      qrString:(NSString*) qrString
                        grDate:(NSString*) grDate;

+ (UIImage *) createLabelImageLandscape: (NSString*) location
                           whs:(NSString*) whs
                   description:(NSString*) description
                      material:(NSString*) material
                       equipNo:(NSString*) equipNo
                        partNo:(NSString*) partNo
                      serialNo:(NSString*) serialNo
                      qrString:(NSString*) qrString
                        grDate:(NSString*) grDate;
@end

NS_ASSUME_NONNULL_END
