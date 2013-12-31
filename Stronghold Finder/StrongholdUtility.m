//
//  StrongholdUtility.m
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import "StrongholdUtility.h"

#pragma mark Minecraft2DCoordinate
@implementation Minecraft2DCoordinate

+ (Minecraft2DCoordinate *)parseFromString:(NSString *)string {
    NSRange range = NSMakeRange(0, string.length);
    NSError *error;
    NSRegularExpression *locationRegularExpression = [NSRegularExpression
                                                      regularExpressionWithPattern:@"^(-?[0-9]+), ?(-?[0-9]+)$"
                                                      options:0
                                                      error:&error];
    
    NSArray *ary = [locationRegularExpression matchesInString:string options:0 range:range];
    if (ary.count != 1) {
        return nil;
    }
    
    NSTextCheckingResult *result = ary[0];
    NSRange xRange = [result rangeAtIndex:1];
    NSRange zRange = [result rangeAtIndex:2];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    
    NSNumber *x = [formatter numberFromString:[string substringWithRange:xRange]];
    NSNumber *z = [formatter numberFromString:[string substringWithRange:zRange]];
    
    return [[Minecraft2DCoordinate alloc] initWithX:x Z:z];
}

+ (Minecraft2DCoordinate *)parseFromTextField:(UITextField *)theTextField {
    Minecraft2DCoordinate *coordinate = [Minecraft2DCoordinate parseFromString:theTextField.text];
    if (coordinate == nil) {
        theTextField.backgroundColor = [UIColor redColor];
    } else {
        theTextField.backgroundColor = [UIColor whiteColor];
    }
    return coordinate;
}

- (id)init {
    self = [super init];
    return self;
}

- (id)initWithX:(NSNumber *)x Z:(NSNumber *)z {
    self = [self init];
    self.x = [x copy];
    self.z = [z copy];
    return self;
}

- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"%@, %@", self.x, self.z];
}

- (id)copyWithZone:(NSZone *)zone {
    // Needs either implicit or explicit cast from (id *) or it'll run into namespace issues (WTF).
    Minecraft2DCoordinate *mc = [[self class] alloc];
    return [mc initWithX:self.x Z:self.z];
}

- (Minecraft2DCoordinate *)rotate:(Minecraft2DCoordinateRotatateDirection)direction {
    short multiplier = (direction == Minecraft2DCoordinateRotateClockwise) ? -1 : 1;
    double r = radians(120 * multiplier);
    
    double x = cos(r) * self.x.doubleValue + -sin(r) * self.z.doubleValue;
    double z = sin(r) * self.x.doubleValue + cos(r) * self.z.doubleValue;
    
    return [[Minecraft2DCoordinate alloc] initWithX:[[NSNumber alloc] initWithDouble:x] Z:[[NSNumber alloc] initWithDouble:z]];
}

@end


#pragma mark - Minecraft2DVector
@implementation Minecraft2DVector

+ (Minecraft2DVector *)parseFromString:(NSString *)string {
    NSRange range = NSMakeRange(0, string.length);
    NSError *error;
    NSRegularExpression *locationRegularExpression = [NSRegularExpression
                                                      regularExpressionWithPattern:@"^(-?[0-9]+), ?(-?[0-9]+), ?(-?[0-9]+)$"
                                                      options:0
                                                      error:&error];
    
    NSArray *ary = [locationRegularExpression matchesInString:string options:0 range:range];
    if (ary.count != 1) {
        return nil;
    }
    
    NSTextCheckingResult *result = ary[0];
    NSRange xRange = [result rangeAtIndex:1];
    NSRange zRange = [result rangeAtIndex:2];
    NSRange fRange = [result rangeAtIndex:3];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    
    NSNumber *x = [formatter numberFromString:[string substringWithRange:xRange]];
    NSNumber *z = [formatter numberFromString:[string substringWithRange:zRange]];
    NSNumber *f = [formatter numberFromString:[string substringWithRange:fRange]];
    
    return [[Minecraft2DVector alloc] initWithX:x Z:z F:f];
}

+ (Minecraft2DVector *)parseFromTextField:(UITextField *)theTextField {
    Minecraft2DVector *vector = [Minecraft2DVector parseFromString:theTextField.text];
    if (vector == nil) {
        theTextField.backgroundColor = [UIColor redColor];
    } else {
        theTextField.backgroundColor = [UIColor whiteColor];
    }
    return vector;
}

- (id)initWithX:(NSNumber *)x Z:(NSNumber *)z F:(NSNumber *)f {
    self.x = [x copy];
    self.z = [z copy];
    self.f = [f copy];
    return self;
}

- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"%@, %@, %@", self.x, self.z, self.f];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithX:self.x Z:self.z F:self.f];
}

@end


#pragma - mark StrongholdUtility
@implementation StrongholdUtility

+ (Minecraft2DCoordinate *)locateStrongholdWithVector1:(Minecraft2DVector *)vector1 Vector2:(Minecraft2DVector *)vector2 {
    double x1 = -vector1.x.doubleValue;
    double z1 = -vector1.z.doubleValue;
    double f1 = -vector1.f.doubleValue;
    f1 = tan(radians(f1));
    
    double x2 = -vector2.x.doubleValue;
    double z2 = -vector2.z.doubleValue;
    double f2 = -vector2.f.doubleValue;
    f2 = tan(radians(f2));
    
    double tmp_z1, tmp_z2, tmp_f1, tmp;
    double x, z;
    
    tmp_z1 = f1 * z1;
    tmp_z2 = f2 * z2;
    
    tmp_z1 = tmp_z1 - x1;
    
    tmp_z1 = x2 + tmp_z1;
    tmp_z1 = tmp_z2 - tmp_z1;
    
    tmp_f1 = f1 - f2;
    
    z = tmp_z1 / tmp_f1;
    tmp = f2 * (z+z2);
    x = tmp - x2;
    
    return [[Minecraft2DCoordinate alloc] initWithX:[[NSNumber alloc] initWithInt:x + 0.5]
                                    Z:[[NSNumber alloc] initWithInt:z + 0.5]];
}


+ (NSDictionary *)guessStrongholdLocations:(Minecraft2DCoordinate *)knownStrongholdLocation {
    return @{
             @"known": knownStrongholdLocation,
             @"clockwise": [knownStrongholdLocation rotate:Minecraft2DCoordinateRotateClockwise],
             @"counterclockwise": [knownStrongholdLocation rotate:Minecraft2DCoordinateRotateCounterclockwise]
             };
}

@end
