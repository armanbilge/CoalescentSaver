//
//  Vector.h
//  coalsave
//
//  Created by Arman Bilge on 7/06/14.
//  Copyright (c) 2014 Computational Evolution Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vector : NSObject {
    NSArray *array;
}
    @property Float64 x;
    @property Float64 y;
    @property Float64 z;

- (id)init;
- (id)initWithX:(Float64)ax y:(Float64)ay z:(Float64)az;
- (id)initWithX:(Float64)ax y:(Float64)ay;
- (Vector*)setWithX:(Float64)ax y:(Float64)ay z:(Float64)az;
- (Vector*)setWithX:(Float64)ax y:(Float64)ay;
- (Vector*)setWithVector:(Vector*)v;
- (Vector*)setWithArray:(NSArray*)a;
- (Vector*)copy;
- (Vector*)addWithVector:(Vector*)v;
+ (Vector*)subWithVector:(Vector*)v1 vector:(Vector*)v2;
- (Vector*)mult:(float)n;
- (Vector*)normalize;
+ (float)distWithVector:(Vector*)v1 vector:(Vector*)v2;

@end
