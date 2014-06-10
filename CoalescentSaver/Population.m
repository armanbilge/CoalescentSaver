//
//  Population.m
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
#import "Population.h"
#import "Processing.h"
#import "Utils.h"

@implementation Population

- (id)initWithSize:(NSSize*)size {
    self = [super init];
    if (self) {
        _size = size;
        _pop = [NSMutableArray new];
        for (int i = 0; i < N; ++i) {
            float w = SSRandomFloatBetween(0, _size->width);
            float h = SSRandomFloatBetween(0, _size->height);
            if (!TWODIMEN) {
                h = BASELINE;
            }
            [_pop addObject:[[Individual alloc] initWithLocation:[[Vector alloc] initWithX:w y:h] size:_size]];
        }
    }
    return self;
}

- (void)run {
    if (DYNAMICS) {
        [self splitstep];
    }
    if (MUTATION) {
        [self mutate];
    }
    [self repulsion];
    [self update];
    [self exclusion];
    [self cleanup];
    [self display];
    for (int i = 0; i < [_pop count]; ++i) {
        Individual* ind = (Individual*) [_pop objectAtIndex:i];
        ind.frameCount += 1;
    }
}

- (NSUInteger)count {
    return [_pop count];
}

- (void)addIndividual:(Individual*) ind {
    [_pop addObject:ind];
}

- (void)replicate {
    if ([_pop count] > 0) {
        int rand = SSRandomIntBetween(0, (int) [_pop count] - 1);;
        Individual* ind = [_pop objectAtIndex:rand];
        float newx = [[ind loc] x] + SSRandomFloatBetween(-1, 1);
        float newy = [[ind loc] y] + SSRandomFloatBetween(-1, 1);
        [_pop addObject:[[Individual alloc] initWithLocation:[[Vector alloc] initWithX:newx y:newy] hue:[ind hue] array:[ind trace] size:_size]];
    } else {
        float w = _size->width/2 + SSRandomFloatBetween(-1, 1);
        float h;
        if (TWODIMEN) {
            h = _size->height/2 + SSRandomFloatBetween(-1, 1);
        } else {
            h = BASELINE;
        }
        [_pop addObject:[[Individual alloc] initWithLocation:[[Vector alloc] initWithX:w y:h] size:_size]];
    }
}

- (BOOL)die {
    BOOL success = false;
    int livecount = 0;
    for (int i = 0; i < [_pop count]; ++i) {
        Individual* ind = (Individual*) [_pop objectAtIndex:i];
        if (![ind dying]) ++livecount;
    }
    if (livecount > 0) {
        Individual* ind;
        do {
            int rand = SSRandomIntBetween(0, (int) [_pop count] - 1);
            ind = [_pop objectAtIndex:rand];
        } while ([ind dying]);
        [ind setDying:true];
        [ind setGrowing:false];
        success = true;
    }
    return success;
}

- (void)splitstep {
    float popBD = 1.0 / GEN * N;
    int events = poissonSample(popBD);
    for (int i = 0; i < events; ++i) {
        [self die];
        [self replicate];
    }
}

- (void)cleanup {
    for (int i = 0; i < [_pop count]; ++i) {
        Individual* ind = [_pop objectAtIndex:i];
        if ([ind r] < 0) {
            [_pop removeObjectAtIndex:i];
            i = 0;
        }
    }
}

- (void)mutate {
    float popMu = 1.0 / GEN * N * MU;
    int events = poissonSample(popMu);
    for (int i = 0; i < events; ++i) {
        int rand = SSRandomIntBetween(0, (int) [_pop count] - 1);
        Individual* ind = [_pop objectAtIndex:rand];
        [ind mutate];
    }
}

- (void)update {
    for (int i = 0; i < [_pop count]; ++i) {
        Individual* ind = [_pop objectAtIndex:i];
        [ind update];
    }
}

- (void)resetTrace {
    for (int i = 0; i < [_pop count]; ++i) {
        Individual* ind = [_pop objectAtIndex:i];
        [ind resetTrace];
    }
}

- (void)display {
    if (TRACING) {
        for (int i = 0; i < [_pop count]; ++i) {
            Individual* ind = [_pop objectAtIndex:i];
            [ind displayTrace];
        }
    }
    for (int i = 0; i < [_pop count]; ++i) {
        Individual* ind = [_pop objectAtIndex:i];
        [ind displayInd];
    }
}

- (void)exclusion {
    for (int i = 0; i < [_pop count]; ++i) {
        Individual* ind = [_pop objectAtIndex:i];
        [[ind loc] setX:constrain([[ind loc] x], [ind r] * 2, _size->width - [ind r] * 2)];
        [[ind loc] setY:constrain([[ind loc] y], [ind r] * 2, _size->height - [ind r] * 2)];
    }
}

- (void)repulsion {
    for (int i = 0; i < [_pop count]; ++i) {
        Individual* ind = [_pop objectAtIndex:i];
        Vector* push = [[Vector alloc] initWithX:0.0 y:0.0];
        float distance;
        Vector* diff;
        for (int j = 0; j < [_pop count]; ++j) {
            if (i != j) {
                Individual* jnd = [_pop objectAtIndex:j];
                diff = [Vector subWithVector:[ind loc] vector:[jnd loc]];
                [diff normalize];
                distance = [Vector distWithVector:[ind loc] vector:[jnd loc]];
                [diff mult:coulomb(distance)];
                [push addWithVector:diff];
            }
        }
        
        diff = [[Vector alloc] initWithX:1.0 y:0.0];
        distance = [[ind loc] x];
        [diff mult:WALLMULTIPLIER * coulomb(distance)];
        [push addWithVector:diff];
        
        diff = [[Vector alloc] initWithX:-1.0 y:0.0];
        distance = _size->width - [[ind loc] x];
        [diff mult:WALLMULTIPLIER * coulomb(distance)];
        [push addWithVector:diff];

        diff = [[Vector alloc] initWithX:0.0 y:1.0];
        distance = [[ind loc] y];
        [diff mult:WALLMULTIPLIER * coulomb(distance)];
        [push addWithVector:diff];
        
        diff = [[Vector alloc] initWithX:0.0 y:-1.0];
        distance = _size->width - [[ind loc] y];
        [diff mult:WALLMULTIPLIER * coulomb(distance)];
        [push addWithVector:diff];

        [[ind acc] addWithVector:push];
    }
}

@end
