//
//  Individual.m
//
//  CoalescentSaver
//  A Mac screensaver derived from Trevor Bedford's coaltrace
//      <https://github.com/trvrb/coaltrace>
//
//  Copyright (C) 2014 Arman D. Bilge <armanbilge@gmail.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import <ScreenSaver/ScreenSaver.h>

#import "Config.h"
#import "Individual.h"
#import "Processing.h"

@implementation Individual

- (id)initWithLocation:(Vector*)l size:(NSSize*)size {
    self = [super init];
    if (self) {
        _size = size;
        _loc = [l copy];
        _vel = [[Vector alloc] initWithX:0.0 y:0.0];
        _acc = [[Vector alloc] initWithX:0.0 y:0.0];
        _r = 0.001;
        _growing = true;
        _dying = false;
        TRACESTEP = 18;
        _frameCount = 0;
        if (MUTATION)
            _hue = SSRandomFloatBetween(0, 1);
        else
            _hue = INDHUE;
        
        if (!TWODIMEN) [_loc setY:BASELINE];
        
        _trace = [NSMutableArray new];
        for (int i = 0; i < TRACEDEPTH; ++i) {
            Vector* tl = [[Vector alloc] initWithX:[_loc x] y:[_loc y] z:_hue];
            [_trace addObject:tl];
        }
    }
    return self;
}

- (id)initWithLocation:(Vector*)l hue:(float)h array:(NSMutableArray*)array size:(NSSize*)size {
    self = [super init];
    if (self) {
        _size = size;
        _loc = [l copy];
        _vel = [[Vector alloc] initWithX:0.0 y:0.0];
        _acc = [[Vector alloc] initWithX:0.0 y:0.0];
        _r = 0.001;
        _growing = true;
        _dying = false;
        _hue = h;
        _trace = [NSMutableArray new];
        TRACESTEP = 18;
        _frameCount = 0;
        for (int i = 0; i < [array count]; ++i) {
            Vector* tl = (Vector*) [array objectAtIndex:i];
            float x = [tl x];
            float y = [tl y];
            float z = [tl z];
            [_trace addObject:[[Vector alloc] initWithX:x y:y z:z]];
        }
    }
    return self;
}

- (void)update {
    [_vel addWithVector:_acc];
    [_vel setX:constrain([_vel x], -MAXVEL, MAXVEL)];
    [_vel setY:constrain([_vel y], -MAXVEL, MAXVEL)];
    
    [_loc addWithVector:_vel];
    
    if (!TWODIMEN) [_loc setY:BASELINE];
    
    if (_growing) _r += 0.9;
    if (_r > 1.3 * MAXRAD) _growing = false;
    if (_dying || _r > MAXRAD) _r -= 0.4;
    
    [self reset];
    
    TRACESTEP = ((int) (_size->height / (float) (TRACEDEPTH * PUSHBACK))) + 1;
    if (_frameCount % TRACESTEP == 0) [self extendTrace];
}

- (void)reset {
    _vel = [Vector new];
    _acc = [Vector new];
}

- (void)extendTrace {
    Vector* tl = [[Vector alloc] initWithX:[_loc x] y:[_loc y] z:_hue];
    [_trace addObject:tl];
    [_trace removeObjectAtIndex:0];
}

- (void)resetTrace {
    _trace = [NSMutableArray new];
    for (int i = 0; i < TRACEDEPTH; ++i) {
        Vector* tl = [[Vector alloc] initWithX:[_loc x] y:[_loc y] z:_hue];
        [_trace addObject:tl];
    }
}

- (void)mutate {
    _hue = SSRandomFloatBetween(0.0, 1.0);
}

- (void) displayTrace {
    float tempx = [_loc x];
    float tempy = [_loc y];
    for (int i = TRACEDEPTH - 1; i > 0; --i) {
        Vector* tl = (Vector*) [_trace objectAtIndex:i];
        if (!TWODIMEN) {
            [tl setY:[tl y] + PUSHBACK];
        }
        NSColor* stroke;
        if (BRANCHCOLORING) {
            stroke = [NSColor colorWithCalibratedHue:[tl z] saturation:0.9 brightness:1.0 alpha:1.0];
        } else if (BLACKBG) {
            stroke = [NSColor colorWithCalibratedHue:[tl z] saturation:0.0 brightness:1.0 alpha:1.0];
        } else {
            stroke = [NSColor colorWithCalibratedHue:[tl z] saturation:0.0 brightness:0.0 alpha:1.0];
        }
        [stroke set];
        NSBezierPath* path = [NSBezierPath bezierPath];
        [path setLineWidth:LINEWIDTH];
        [path moveToPoint:NSMakePoint(tempx, tempy)];
        [path lineToPoint:NSMakePoint([tl x], [tl y])];
        [path stroke];
        tempx = [tl x];
        tempy = [tl y];
    }
}

- (void)displayInd {
    NSRect rect = NSMakeRect([_loc x] - _r * 2, [_loc y] - _r * 2, _r * 4, _r * 4);
    NSColor* fill = [NSColor colorWithCalibratedHue:_hue saturation:0.9 brightness:1.0 alpha:1.0];
    NSColor* stroke = [NSColor colorWithCalibratedHue:0.0 saturation:0.0 brightness:1.0 alpha:1.0];
    [stroke set];
    [fill setFill];
    NSBezierPath* path = [NSBezierPath bezierPathWithOvalInRect:rect];
    [path fill];
    [path setLineWidth:LINEWIDTH];
    [path stroke];
}

@end
