#import "PrintJob.h"
#import <React/RCTEventDispatcher.h>
#import <React/RCTUtils.h>
#import <React/RCTImageLoader.h>

@implementation PrintJob

@synthesize printerSerialNumber;

@synthesize location;
@synthesize whs;
@synthesize description;
@synthesize material;
@synthesize equipNo;
@synthesize partNo;
@synthesize serialNo;
@synthesize qrString;
@synthesize grDate;

@synthesize resolve;
@synthesize reject;

- (void)dealloc
{
    // free memory (since the property was declared copy) ARC is off to support zebra "pil og bue" framework.
    [printerSerialNumber release];
    
    [location release];
    [whs release];
    [description release];
    [material release];
    [equipNo release];
    [partNo release];
    [serialNo release];
    [qrString release];
    [grDate release];
    
    [resolve release];
    [reject release];
    [super dealloc];
}
@end
