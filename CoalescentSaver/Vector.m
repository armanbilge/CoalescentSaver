//
//  Vector.m
//  coalsave
//
//  Created by Arman Bilge on 7/06/14.
//  Copyright (c) 2014 Computational Evolution Group. All rights reserved.
//

#import "Vector.h"

@implementation Vector

- (id)init {
    return [super init];
}

- (id)initWithX:(Float64)ax y:(Float64)ay z:(Float64)az {
    self = [super init];
    if (self) {
        _x = ax;
        _y = ay;
        _z = az;
    }
    return self;
}

- (id)initWithX:(Float64)ax y:(Float64)ay {
    return [self initWithX:ax y:ay z:0.0];
}

- (Vector*)setWithX:(Float64)ax y:(Float64)ay z:(Float64)az {
    _x = ax;
    _y = ay;
    _z = az;
    return self;
}

- (Vector*)setWithX:(Float64)ax y:(Float64)ay {
    _x = ax;
    _y = ay;
    return self;
}

- (Vector*)setWithVector:(Vector*)v {
    _x = [v x];
    _y = [v y];
    _z = [v z];
    return self;
}

- (Vector*)setWithArray:(NSArray*)a {
    if ([a count] >= 2) {
        _x = [[a objectAtIndex:0] floatValue];
        _y = [[a objectAtIndex:1] floatValue];
    }
    if ([a count] >= 3) {
        _x = [[a objectAtIndex:2] floatValue];
    }
    return self;
}

- (Vector*)copy {
    return [[Vector alloc] initWithX:[self x] y:[self y] z:[self z]];
}

- (Vector*)addWithVector:(Vector*)v {
    _x += [v x];
    _y += [v y];
    _z += [v z];
    return self;
}

+ (Vector*)subWithVector:(Vector*)v1 vector:(Vector*)v2 {
    return [Vector subWithVector:v1 vector:v2 target:nil];
}

+ (Vector*)subWithVector:(Vector*)v1 vector:(Vector*)v2 target:(Vector*)t {
    if (t == nil) {
        t = [[Vector alloc] initWithX:[v1 x] - [v2 x] y:[v1 y] - [v2 y] z:[v1 z] - [v2 z]];
    } else {
        [t setWithX:[v1 x] - [v2 x] y:[v1 y] - [v2 y] z:[v1 z] - [v2 z]];
    }
    return t;
}

- (Vector*)mult:(float)n {
    _x *= n;
    _y *= n;
    _z *= n;
    return self;
}

- (Vector*)normalize {
    float m = [self mag];
    if (m != 0 && m != 1)
        [self div:m];
    return self;
}

- (float)mag {
    return sqrtf(_x * _x + _y * _y + _z * _z);
}

- (Vector*)div:(float)n {
    _x /= n;
    _y /= n;
    _z /= n;
    return self;
}

+ (float)distWithVector:(Vector*)v1 vector:(Vector*)v2 {
    float dx = [v1 x] - [v2 x];
    float dy = [v1 y] - [v2 y];
    float dz = [v1 z] - [v2 z];
    return sqrtf(dx * dx + dy * dy + dz * dz);
}

@end
