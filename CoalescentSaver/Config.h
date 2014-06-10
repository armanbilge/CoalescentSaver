//
//  Config.h
//  coalsave
//
//  Created by Arman Bilge on 8/06/14.
//  Copyright (c) 2014 Computational Evolution Group. All rights reserved.
//

#define TWODIMEN false
#define MUTATION true
#define TRACING true
#define DYNAMICS true
#define STATISTICS false
#define HELP false
#define FRATE false
#define BLACKBG true
#define BRANCHCOLORING true

#define CHARGE 30
#define MAXVEL 2.0
#define MAXRAD 6
#define BASELINE 25
#define WALLMULTIPLIER 20
#define TRACEDEPTH 20
#define PUSHBACK 0.75
#define LINEWIDTH 2.0

#if BLACKBG
#define BG 0.0
#define OUTLINE 1.0
#else
#define BG 1.0
#define OUTLINE 0.0
#endif

#define N 2
#define MU 0.1
#define GEN 60.0

#define INDHUE 0.95
#define LOOPING true

#define FRAMERATE 60.0
