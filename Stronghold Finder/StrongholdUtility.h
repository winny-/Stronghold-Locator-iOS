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
    Minecraft2DCoordinateRotateClockwise,
    Minecraft2DCoordinateRotateCounterclockwise
} Minecraft2DCoordinateRotatateDirection;

#define radians(degrees) degrees * (M_PI / 180)

#define kMinecraft2DCoordinateRegex @"^\\s*(-?[0-9]+(?:\\.[0-9]+)?),?\\s+(-?[0-9]+(?:\\.[0-9]+)?)\\s*$"
#define kMinecraft2DVectorRegex @"^\\s*(-?[0-9]+(?:\\.[0-9]+)?),?\\s+(-?[0-9]+(?:\\.[0-9]+)?),?\\s+(-?[0-9]+(?:\\.[0-9]+)?)\\s*$"

#pragma mark - Minecraft2DCoordinate
@interface Minecraft2DCoordinate : NSObject

@property NSNumber *x;
@property NSNumber *z;

+ (Minecraft2DCoordinate *)parseFromString:(NSString *)string;
+ (Minecraft2DCoordinate *)parseFromTextField:(UITextField *)theTextField;

- (id)initWithX:(NSNumber *)x Z:(NSNumber *)z;

- (NSString *)description;
- (id)copyWithZone:(NSZone *)zone;

@end


#pragma mark - Minecraft2DVector
@interface Minecraft2DVector : NSObject

@property NSNumber *x;
@property NSNumber *z;
@property NSNumber *f;

+ (Minecraft2DVector *)parseFromString:(NSString *)string;
+ (Minecraft2DVector *)parseFromTextField:(UITextField *)theTextField;

- (id)initWithX:(NSNumber *)x Z:(NSNumber *)z F:(NSNumber *)f;

- (NSString *)description;
- (id)copyWithZone:(NSZone *)zone;

@end


#pragma mark - StrongholdUtility
@interface StrongholdUtility : NSObject

+ (Minecraft2DVector *)locateStrongholdWithVector1:(Minecraft2DVector *)vector1 Vector2:(Minecraft2DVector *)vector2;
+ (NSDictionary *)guessStrongholdLocations:(Minecraft2DCoordinate *)knownStrongholdLocation;

@end
