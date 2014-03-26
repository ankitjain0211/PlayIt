//
//  PIUtility.h
//  PlayIt
//
//  Created by Ankit on 26/03/14.
//  Copyright (c) 2014 PlayIt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIUtility : NSObject
+(id)sharedUtility;
// Method to make image circle
+(void)applyTwoCornerMask:(CALayer *)layer withRadius:(CGFloat)radius;
@end
