#import "LabelHelper.h"
#import <React/RCTEventDispatcher.h>
#import <React/RCTUtils.h>
#import <React/RCTImageLoader.h>

@implementation LabelHelper




+ (UIImage *) createLabelImageLandscape: (NSString*) location
                           whs:(NSString*) whs
                   description:(NSString*) description
                      material:(NSString*) material
                       equipNo:(NSString*) equipNo
                        partNo:(NSString*) partNo
                      serialNo:(NSString*) serialNo
                      qrString:(NSString*) qrString
                        grDate:(NSString*) grDate
{
    CGFloat lineHeight = 50.0;
    CGFloat linePosition = 0;
    CGFloat margin = 25.0;
    CGFloat columSize = 190.0;
    
    
    
    // A7 paper 74 x 105 mm
    CGFloat imageWidth = 105  * 7.9;
    CGFloat imageHeight = 74 * 7.9;
    
    CGFloat imageBox = imageWidth / 4;
    
    CGFloat tableLineStart = 330.0;
    CGFloat tableHeaderSize = 30.0;
    CGFloat tableTextSize = 35.0;
    
    // create qr image
    NSData *stringData = [qrString dataUsingEncoding: NSISOLatin1StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *qrImage = qrFilter.outputImage; //qrFilter.outputImage;
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(10.0, 10.0)];
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage
                                             scale:1.0
                                       orientation:UIImageOrientationUp];
    
    
    // label frame
    UIColor *fillColor=[UIColor whiteColor];
    CGRect frame = CGRectMake(0, 0, imageWidth, imageHeight);
    
    
    // begin drawing context
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    CGContextFillRect(context, frame);
    
    // draw text
    
    
    // floatLeftLongTextStyle
    NSMutableParagraphStyle *longTextStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    // floatLeftLongTextStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    longTextStyle.lineBreakMode = NSLineBreakByWordWrapping;
    longTextStyle.alignment = NSTextAlignmentLeft;
    // floatLeftStyle
    NSMutableParagraphStyle *floatLeftStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    floatLeftStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    floatLeftStyle.alignment = NSTextAlignmentLeft;
    
    // floatRightStyle
    NSMutableParagraphStyle *floatRightStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    floatRightStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    floatRightStyle.alignment = NSTextAlignmentRight;
    
    // centerStyle
    NSMutableParagraphStyle *centerStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    centerStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    centerStyle.alignment = NSTextAlignmentCenter;
    
    
    [[UIColor blackColor] set];
    
    
    // line 1
    [@"Loc:" drawInRect:CGRectMake(margin, margin + 5, imageWidth, imageHeight)
         withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:tableHeaderSize],
                           NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [location drawInRect:CGRectMake(margin + columSize, 20, imageWidth, imageHeight)
          withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:45],
                            NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [@"Whs:" drawInRect:CGRectMake(margin, 85, imageWidth, imageHeight)
         withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:tableHeaderSize],
                           NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [whs drawInRect:CGRectMake(margin + columSize, 75, imageWidth, imageHeight)
     withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:45],
                       NSParagraphStyleAttributeName: floatLeftStyle}];
    
    // line 2
    
    CGFloat descriptionBoxWidth = imageWidth - imageBox - 35 - margin;
    
    CGSize size = [description sizeWithAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:40],
                                                     NSParagraphStyleAttributeName: longTextStyle}];
    NSLog(@"%f", size.width);
    
    CGFloat desctiptionLength =  size.width / descriptionBoxWidth;
    
    NSLog(@"%f", desctiptionLength);
    // one line
    CGFloat descriptionLinePosition = 195.0;
    
    
    if (desctiptionLength >= 2.0) {
        // 3 or more lines
        descriptionLinePosition = 145.0;
    }else if (desctiptionLength > 1) {
        // 2 lines
        descriptionLinePosition = 170.0;
    }
    
    
    
    [description drawInRect:CGRectMake(margin, descriptionLinePosition, descriptionBoxWidth, 150)
             withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:40],
                               NSParagraphStyleAttributeName: longTextStyle}];
    
    
    
    // line 3
    
    [@"Material:" drawInRect:CGRectMake(margin, tableLineStart, imageWidth, imageHeight)
              withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:tableHeaderSize],
                                NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [material drawInRect:CGRectMake(margin + columSize, tableLineStart - 2.5, imageWidth, imageHeight)
           withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:tableTextSize],
                             NSParagraphStyleAttributeName: floatLeftStyle}];
    
    // line 3
    
    linePosition += lineHeight;
    [@"Equip No:" drawInRect:CGRectMake(margin, tableLineStart + linePosition, imageWidth, imageHeight)
              withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:tableHeaderSize],
                                NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [equipNo drawInRect:CGRectMake(margin + columSize, tableLineStart - 2.5 + linePosition, imageWidth, imageHeight)
         withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:tableTextSize],
                           NSParagraphStyleAttributeName: floatLeftStyle}];
    
    
    
    // line 4
    
    linePosition += lineHeight;
    [@"Part No.:" drawInRect:CGRectMake(margin, tableLineStart + linePosition, imageWidth, imageHeight)
              withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:tableHeaderSize],
                                NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [partNo drawInRect:CGRectMake(margin + columSize, tableLineStart - 2.5 + linePosition, imageWidth, imageHeight)
        withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:tableTextSize],
                          NSParagraphStyleAttributeName: floatLeftStyle}];
    
    // line 5
    
    linePosition += lineHeight;
    [@"Serial No:" drawInRect:CGRectMake(margin, tableLineStart + linePosition, imageWidth, imageHeight)
               withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:tableHeaderSize],
                                 NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [serialNo drawInRect:CGRectMake(margin + columSize, tableLineStart - 2.5 + linePosition, imageWidth, imageHeight)
          withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:tableTextSize],
                            NSParagraphStyleAttributeName: floatLeftStyle}];
    
    
    // line 6
    
    linePosition += lineHeight;
    [@"GR Date:" drawInRect:CGRectMake(margin, tableLineStart + linePosition, imageWidth, imageHeight)
             withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:tableHeaderSize],
                               NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [grDate drawInRect:CGRectMake(margin + columSize, tableLineStart - 2.5 + linePosition, imageWidth, imageHeight)
        withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:tableTextSize],
                          NSParagraphStyleAttributeName: floatLeftStyle}];
    
    // draw line
    
    /*
     CGContextSetLineWidth(context, 2.0);
     CGContextMoveToPoint(context, margin, 80);
     CGContextAddLineToPoint(context, imageWidth -margin, 80);
     CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
     CGContextStrokePath(context);
     */
    
    
    // draw QR image (top right corner)
    
    [qrUIImage drawInRect:CGRectMake(imageWidth - 25 - imageBox, 30, imageBox, imageBox)];
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;

}




+ (UIImage *) createLabelImage: (NSString*) location
                      whs:(NSString*) whs
              description:(NSString*) description
                 material:(NSString*) material
                  equipNo:(NSString*) equipNo
                   partNo:(NSString*) partNo
                 serialNo:(NSString*) serialNo
                 qrString:(NSString*) qrString
                   grDate:(NSString*) grDate
{
    
    CGFloat lineHeight = 50.0;
    CGFloat linePosition = 0;
    CGFloat margin = 15.0;
    CGFloat imageWidth = 400.0;
    CGFloat imageHeight = 700.0;
    
    // create qr image
    NSData *stringData = [qrString dataUsingEncoding: NSISOLatin1StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *qrImage = qrFilter.outputImage; //qrFilter.outputImage;
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(10.0, 10.0)];
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage
                                             scale:1.0
                                       orientation:UIImageOrientationUp];
    
    
    // label frame
    UIColor *fillColor=[UIColor whiteColor];
    CGRect frame = CGRectMake(0, 0, imageWidth, imageHeight);
    
    
    // begin drawing context
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    CGContextFillRect(context, frame);
    
    // draw text
    
    
    // centerLongTextStyle
    NSMutableParagraphStyle *centerLongTextStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    centerLongTextStyle.lineBreakMode = NSLineBreakByWordWrapping;
    centerLongTextStyle.alignment = NSTextAlignmentCenter;
    
    // floatLeftStyle
    NSMutableParagraphStyle *floatLeftStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    floatLeftStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    floatLeftStyle.alignment = NSTextAlignmentLeft;
    
    // floatRightStyle
    NSMutableParagraphStyle *floatRightStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    floatRightStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    floatRightStyle.alignment = NSTextAlignmentRight;
    
    // centerStyle
    NSMutableParagraphStyle *centerStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    centerStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    centerStyle.alignment = NSTextAlignmentCenter;
    
    
    [[UIColor blackColor] set];
    
    
    // line 1
    [@"Loc:" drawInRect:CGRectMake(margin, 40, imageWidth, imageHeight)
         withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:20],
                           NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [location drawInRect:CGRectMake(margin + 60, 35, imageWidth, imageHeight)
          withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:30],
                            NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [@"Whs:" drawInRect:CGRectMake(margin + 210, 40, imageWidth, imageHeight)
         withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:18],
                           NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [whs drawInRect:CGRectMake(0, 37, imageWidth - margin, imageHeight)
     withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:24],
                       NSParagraphStyleAttributeName: floatRightStyle}];
    
    // line 2
    CGSize size = [description sizeWithAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:22],
                                                     NSParagraphStyleAttributeName: centerLongTextStyle}];
    NSLog(@"%f", size.width);
    
    CGFloat descriptionLinePosition = 110.0;
    
    if (size.width > imageWidth) {
        descriptionLinePosition = 95.0;
    }
    
    [description drawInRect:CGRectMake(margin, descriptionLinePosition, imageWidth - margin, 70)
             withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:22],
                               NSParagraphStyleAttributeName: centerLongTextStyle}];
    
    // line 3
    
    [@"Material:" drawInRect:CGRectMake(margin, 160, imageWidth, imageHeight)
              withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:20],
                                NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [material drawInRect:CGRectMake(margin + 100, 158.5, imageWidth, imageHeight)
          withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:24],
                            NSParagraphStyleAttributeName: floatLeftStyle}];
    
    // line 3
    
    linePosition += lineHeight;
    [@"Equip No:" drawInRect:CGRectMake(margin, 160 + linePosition, imageWidth, imageHeight)
              withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:20],
                                NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [equipNo drawInRect:CGRectMake(margin + 100, 158.5 + linePosition, imageWidth, imageHeight)
         withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:24],
                           NSParagraphStyleAttributeName: floatLeftStyle}];
    
    
    
    // line 4
    
    linePosition += lineHeight;
    [@"Part No.:" drawInRect:CGRectMake(margin, 160 + linePosition, imageWidth, imageHeight)
              withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:20],
                                NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [partNo drawInRect:CGRectMake(margin + 100, 158.5 + linePosition, imageWidth, imageHeight)
        withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:24],
                          NSParagraphStyleAttributeName: floatLeftStyle}];
    
    // line 5
    
    linePosition += lineHeight;
    [@"Serial No:" drawInRect:CGRectMake(margin, 160 + linePosition, imageWidth, imageHeight)
               withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:20],
                                 NSParagraphStyleAttributeName: floatLeftStyle}];
    
    [serialNo drawInRect:CGRectMake(margin + 100, 158.5 + linePosition, imageWidth, imageHeight)
          withAttributes:@{ NSFontAttributeName: [UIFont boldSystemFontOfSize:24],
                            NSParagraphStyleAttributeName: floatLeftStyle}];
    
    
    // line 6
    
    linePosition += lineHeight;
    [@"GR Date:" drawInRect:CGRectMake(margin, 380 + imageWidth / 2, imageWidth - margin, imageHeight)
             withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:20],
                               NSParagraphStyleAttributeName: centerStyle}];
    
    [grDate drawInRect:CGRectMake(0, 380 + imageWidth / 2, imageWidth - margin, imageHeight)
        withAttributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:20],
                          NSParagraphStyleAttributeName: floatRightStyle}];
    
    // draw line
    
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, margin, 80);
    CGContextAddLineToPoint(context, imageWidth -margin, 80);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextStrokePath(context);
    
    
    
    // draw QR image
    [qrUIImage drawInRect:CGRectMake(100, 370, imageWidth / 2, imageWidth / 2)];
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
