//
//  Individual.h
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
