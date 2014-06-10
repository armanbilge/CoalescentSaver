//
//  Utils.m
//  coalsave
//
//  Created by Arman Bilge on 9/06/14.
//  Copyright (c) 2014 Computational Evolution Group. All rights reserved.
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