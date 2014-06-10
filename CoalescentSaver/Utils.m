//
//  Utils.m
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
#import "Utils.h"

float coulomb(float d) {
    float force;
    if (d > 0) {
        force = CHARGE * CHARGE / (d * d);
    } else {
        force = 10000;
    }
    return force;
}

int poissonSample(float lambda) {
    float t = exp2f(-lambda);
    int k = 0;
    float p = 1;
    while (p > t) {
        ++k;
        p *= SSRandomFloatBetween(0, 1);
    }
    return k - 1;
}

float coalInterval(int k) {
    
    float cof = 2.0 / (k-1) * k;
    float generations = cof * N * 0.5;
    float frames = generations * GEN;
    float mod = frames * PUSHBACK;
    
    return mod;
    
}