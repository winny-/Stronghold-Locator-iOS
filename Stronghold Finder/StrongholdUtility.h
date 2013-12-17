//
//  StrongholdUtility.h
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

typedef enum {
    SVectorRotateClockwise,
    SVectorRotateCounterclockwise
} SVectorRotatateDirection;

#define radians(degrees) degrees * (M_PI / 180)

@interface SVector : NSObject

@property NSNumber *x;
@property NSNumber *f;
@property NSNumber *z;

- (id)initWithX:(NSNumber *)myX Z:(NSNumber *)myZ;
- (id)initWithX:(NSNumber *)myX Z:(NSNumber *)myZ F:(NSNumber *)myF;

- (NSString *)description;
- (SVector *)copyWithZone:(NSZone *)zone;

@end


@interface StrongholdUtility : NSObject

+ (SVector *)locateStrongholdWithVector1:(SVector *)vector1 Vector2:(SVector *)vector2;
+ (NSDictionary *)guessStrongholdLocations:(SVector *)knownStrongholdLocation;
+ (SVector *)parseSVectorFromString:(NSString *)string withF:(BOOL)withF;
+ (SVector *)parseSVectorFromTextField:(UITextField *)theTextField withF:(BOOL)withF;
@end
