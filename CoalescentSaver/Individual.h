//
//  Individual.h
//  coalsave
//
//  Created by Arman Bilge on 7/06/14.
//  Copyright (c) 2014 Computational Evolution Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector.h"

@interface Individual : NSObject {
    @private
    int TRACESTEP;
}

@property Vector *loc;
@property Vector *vel;
@property Vector *acc;
@property float r;
@property BOOL growing;
@property BOOL dying;
@property float hue;
@property NSMutableArray *trace;
@property NSSize *size;
@property int frameCount;

- (id)initWithLocation:(Vector*)l size:(NSSize*)size;
- (id)initWithLocation:(Vector*)l hue:(float)h array:(NSMutableArray*)array size:(NSSize*)size;
- (void)mutate;
- (void)update;
- (void)resetTrace;
- (void)displayInd;
- (void) displayTrace;

@end
