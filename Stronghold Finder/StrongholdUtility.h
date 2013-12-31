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

#pragma mark - MinecraftCoordinate
@interface MinecraftCoordinate : NSObject

@property NSNumber *x;
@property NSNumber *y;
@property NSNumber *z;

- (id)initWithX:(NSNumber *)x Z:(NSNumber *)z;
- (id)initWithX:(NSNumber *)x Y:(NSNumber *)y Z:(NSNumber *)z;

- (NSString *)description;
- (id)copyWithZone:(NSZone *)zone;

@end

#pragma mark - Minecraft2DVector
@interface Minecraft2DVector : MinecraftCoordinate

@property NSNumber *f;

- (id)initWithX:(NSNumber *)x Z:(NSNumber *)z F:(NSNumber *)f;

- (NSString *)description;
- (id)copyWithZone:(NSZone *)zone;

@end

#pragma mark - StrongholdUtility
@interface StrongholdUtility : NSObject

+ (Minecraft2DVector *)locateStrongholdWithVector1:(Minecraft2DVector *)vector1 Vector2:(Minecraft2DVector *)vector2;
+ (NSDictionary *)guessStrongholdLocations:(Minecraft2DVector *)knownStrongholdLocation;
+ (Minecraft2DVector *)parseMinecraft2DVectorFromString:(NSString *)string withF:(BOOL)withF;
+ (Minecraft2DVector *)parseMinecraft2DVectorFromTextField:(UITextField *)theTextField withF:(BOOL)withF;

@end
