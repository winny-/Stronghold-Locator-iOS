//
//  StrongholdUtility.m
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import "StrongholdUtility.h"

#pragma mark MinecraftCoordinate
@implementation MinecraftCoordinate
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

- (id)initWithX:(NSNumber *)x Y:(NSNumber *)y Z:(NSNumber *)z {
    self = [self initWithX:x Z:z];
    self.y = [y copy];
    return self;
}

- (NSString *)description {
    if (self.y != nil) {
        return [[NSString alloc] initWithFormat:@"%@, %@, %@", self.x, self.y, self.z];
    }
    return [[NSString alloc] initWithFormat:@"%@, %@", self.x, self.z];
}

- (id)copyWithZone:(NSZone *)zone {
    // Needs either implicit or explicit cast from (id *) or it'll run into namespace issues (WTF).
    MinecraftCoordinate *mc = [[self class] alloc];
    return [mc initWithX:self.x Y:self.y Z:self.z];
}

@end


#pragma mark - Minecraft2DVector
@implementation Minecraft2DVector

- (id)initWithX:(NSNumber *)x Z:(NSNumber *)z F:(NSNumber *)f {
    self = [self initWithX:x Z:z];
    self.f = [f copy];
    return self;
}

- (Minecraft2DVector *)rotate:(SVectorRotatateDirection)direction {
    float multiplier = (direction == SVectorRotateClockwise) ? -1 : 1;
    float r = radians(120 * multiplier);
    
    float x = cosf(r) * self.x.floatValue + -sinf(r) * self.z.floatValue;
    float z = sinf(r) * self.x.floatValue + cosf(r) * self.z.floatValue;
    
    return [[Minecraft2DVector alloc] initWithX:[[NSNumber alloc] initWithFloat:x] Z:[[NSNumber alloc] initWithFloat:z]];
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

+ (Minecraft2DVector *)locateStrongholdWithVector1:(Minecraft2DVector *)vector1 Vector2:(Minecraft2DVector *)vector2 {
    float x1 = -vector1.x.floatValue;
    float z1 = -vector1.z.floatValue;
    float f1 = -vector1.f.floatValue;
    f1 = tanf(radians(f1));
    
    float x2 = -vector2.x.floatValue;
    float z2 = -vector2.z.floatValue;
    float f2 = -vector2.f.floatValue;
    f2 = tanf(radians(f2));
    
    float tmp_z1, tmp_z2, tmp_f1, tmp;
    float x, z;
    
    tmp_z1 = f1 * z1;
    tmp_z2 = f2 * z2;
    
    tmp_z1 = tmp_z1 - x1;
    
    tmp_z1 = x2 + tmp_z1;
    tmp_z1 = tmp_z2 - tmp_z1;
    
    tmp_f1 = f1 - f2;
    
    z = tmp_z1 / tmp_f1;
    tmp = f2 * (z+z2);
    x = tmp - x2;
    
    return [[Minecraft2DVector alloc] initWithX:[[NSNumber alloc] initWithInt:x + 0.5]
                                    Z:[[NSNumber alloc] initWithInt:z + 0.5]];
}


+ (NSDictionary *)guessStrongholdLocations:(Minecraft2DVector *)knownStrongholdLocation {
    return @{
             @"known": knownStrongholdLocation,
             @"clockwise": [knownStrongholdLocation rotate:SVectorRotateClockwise],
             @"counterclockwise": [knownStrongholdLocation rotate:SVectorRotateCounterclockwise]
             };
}

+ (Minecraft2DVector *)parseMinecraft2DVectorFromString:(NSString *)string withF:(BOOL)withF {
    
    NSString *pattern;
    if (withF) {
        pattern = @"^(-?[0-9]+), ?(-?[0-9]+), ?(-?[0-9]+)$";
    } else {
        pattern = @"^(-?[0-9]+), ?(-?[0-9]+)$";
    }
    
    NSRange range = NSMakeRange(0, string.length);
    NSError *error;
    NSRegularExpression *locationRegularExpression = [NSRegularExpression
                                                       regularExpressionWithPattern:pattern
                                                       options:0
                                                       error:&error];
    
    NSArray *ary = [locationRegularExpression matchesInString:string options:0 range:range];
    if (ary.count != 1) {
        return nil;
    }
    
    NSTextCheckingResult *result = ary[0];
    NSRange xRange = [result rangeAtIndex:1];
    NSRange zRange = [result rangeAtIndex:2];
    NSRange fRange;
    if (withF) {
        fRange = [result rangeAtIndex:3];
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    
    NSNumber *x = [formatter numberFromString:[string substringWithRange:xRange]];
    NSNumber *z = [formatter numberFromString:[string substringWithRange:zRange]];
    NSNumber *f;
    if (withF) {
        f = [formatter numberFromString:[string substringWithRange:fRange]];
    }
    
    return [[Minecraft2DVector alloc] initWithX:x Z:z F:f];
}

+ (Minecraft2DVector *)parseMinecraft2DVectorFromTextField:(UITextField *)theTextField withF:(BOOL)withF {
    Minecraft2DVector *vector = [StrongholdUtility parseMinecraft2DVectorFromString:theTextField.text withF:withF];
    if (vector == nil) {
        theTextField.backgroundColor = [UIColor redColor];
    } else {
        theTextField.backgroundColor = [UIColor whiteColor];
    }
    return vector;
}

@end
