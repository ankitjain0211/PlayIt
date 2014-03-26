//
//  PIUtility.m
//  PlayIt
//
//  Created by Ankit on 26/03/14.
//  Copyright (c) 2014 PlayIt. All rights reserved.
//

#import "PIUtility.h"

@implementation PIUtility

+(id)sharedUtility {
    static PIUtility *sharedMyUtility = nil;
    if (!sharedMyUtility) {
        sharedMyUtility = [[super allocWithZone:nil] init];
    }
    return sharedMyUtility;
}

#pragma mark - Image circle method

+(void)applyTwoCornerMask:(CALayer *)layer withRadius:(CGFloat)radius {
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = layer.bounds;
    [mask setFillColor:[[UIColor blackColor] CGColor]];
    
    CGFloat width = layer.bounds.size.width;
    CGFloat height = layer.bounds.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, width, 0);
    CGPathAddLineToPoint(path, NULL, width, height - radius);
    CGPathAddCurveToPoint(path, NULL, width, height, width - radius, height, width - radius, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathAddLineToPoint(path, NULL, 0, radius);
    CGPathAddCurveToPoint(path, NULL, 0, 0, radius, 0, radius, 0);
    CGPathCloseSubpath(path);
    [mask setPath:path];
    CGPathRelease(path);
    
    layer.mask = mask;
}

@end
