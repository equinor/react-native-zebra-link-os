#import "RNZebraLinkOs.h"
#import <React/RCTEventDispatcher.h>
#import <React/RCTUtils.h>
#import <React/RCTImageLoader.h>

#import "ZebraPrinterConnection.h"
#import "ZebraPrinter.h"
#import "ZebraPrinterFactory.h"
#import "TcpPrinterConnection.h"
#import "MfiBtPrinterConnection.h"
#import <ExternalAccessory/ExternalAccessory.h>

#import "PrintJob.h"
#import "LabelHelper.h"

@implementation RNZebraLinkOs

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(getAvailablePrinters:
                  (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    EAAccessoryManager *sam = [EAAccessoryManager sharedAccessoryManager];
    NSArray * connectedAccessories = [sam connectedAccessories];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    
    for (EAAccessory *accessory in connectedAccessories) {
        if([accessory.protocolStrings indexOfObject:@"com.zebra.rawport"] != NSNotFound){
            dict[accessory.name] = accessory.serialNumber;
        }
    }
    
    resolve(dict);
}



RCT_EXPORT_METHOD(print:(NSString *)printerSerialNumber
                  label:(NSDictionary *)label
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    
    PrintJob *job = [[PrintJob alloc] init];
    
    job.resolve = ^(NSString * _Nonnull message) {
        NSDictionary *attributes = @{
                                     @"textPrinted": message
                                     };
        resolve(attributes);
    };
    
    job.reject = ^(NSString * _Nonnull message) {
        reject(@"ENOENT", message, NULL);
    };
    
    NSString* location = [RCTConvert NSString:label[@"location"]];
    NSString* whs = [RCTConvert NSString:label[@"whs"]];
    NSString* description = [RCTConvert NSString:label[@"description"]];
    NSString* material = [RCTConvert NSString:label[@"material"]];
    NSString* equipNo = [RCTConvert NSString:label[@"equipNo"]];
    NSString* partNo = [RCTConvert NSString:label[@"partNo"]];
    NSString* serialNo = [RCTConvert NSString:label[@"serialNo"]];
    NSString* qrString = [RCTConvert NSString:label[@"qrString"]];
    NSString* grDate = [RCTConvert NSString:label[@"grDate"]];
    
    
    [job setPrinterSerialNumber:printerSerialNumber];
    
    [job setLocation:location];
    [job setWhs:whs];
    [job setDescription:description];
    [job setMaterial:material];
    [job setEquipNo:equipNo];
    [job setPartNo:partNo];
    [job setSerialNo:serialNo];
    [job setQrString:qrString];
    [job setGrDate:grDate];


    if ( location == nil) {
        reject(@"ENOENT", @"missing location", NULL);
    } else {
        [NSThread detachNewThreadSelector:@selector(sendPrintJob: ) toTarget:self withObject:job];
    }
    
}



- (void) sendPrintJob: (PrintJob* ) job {
    
    NSString *serialNumber = job.printerSerialNumber;
    
    //Find the Zebra Bluetooth Accessory
    EAAccessoryManager *sam = [EAAccessoryManager sharedAccessoryManager];
    NSArray * connectedAccessories = [sam connectedAccessories];
    

    // if print job serialNumber is blank, find the first zebra printer.
    if ([serialNumber isEqualToString:@""]) {
        for (EAAccessory *accessory in connectedAccessories) {
            if([accessory.protocolStrings indexOfObject:@"com.zebra.rawport"] != NSNotFound){
                serialNumber = accessory.serialNumber;
                break;
            }
        }
    }
    
    // Instantiate connection to Zebra Bluetooth accessory
    id<ZebraPrinterConnection, NSObject> printerConnection = [[MfiBtPrinterConnection alloc] initWithSerialNumber:serialNumber];
    // Open the connection - physical connection is established here.
    BOOL success = [printerConnection open];
    
    NSError *error = nil;
    
    id<ZebraPrinter, NSObject> printer = [ZebraPrinterFactory getInstance:printerConnection error:&error];
    id<GraphicsUtil, NSObject> graphicsUtil = [printer getGraphicsUtil];
    
    
    UIImage * image = [LabelHelper createLabelImageLandscape:job.location
            whs:job.whs
            description:job.description
            material:job.material
            equipNo:job.equipNo
            partNo:job.partNo
            serialNo:job.serialNo
            qrString:job.qrString
            grDate:job.grDate];
    
    CGImageRef img = image.CGImage;
    
    // Print Image
    success = [graphicsUtil printImage:img atX:0 atY:15 withWidth:829.5 withHeight:584.6 andIsInsideFormat:NO error:&error];
    
    [NSThread sleepForTimeInterval:2.0f];


    [printerConnection close];
    [printerConnection release];
    // [job release];
    
    if (success == YES && error == nil) {
        job.resolve(@"success");
    } else if (error != nil) {
        job.reject([error localizedDescription]);
    } else {
        job.reject(@"unknown error");
    }

}

@end
