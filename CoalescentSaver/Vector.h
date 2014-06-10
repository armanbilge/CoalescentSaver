//
//  Vector.h
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
