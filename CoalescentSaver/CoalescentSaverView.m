//
//  CoalescentSaverView.m
//  CoalescentSaver
//
//  Created by Arman Bilge on 10/06/14.
//  Copyright (c) 2014 Computational Evolution Group. All rights reserved.
//

#import "CoalescentSaverView.h"

#import "Config.h"
#import "Population.h"

@implementation CoalescentSaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1.0/FRAMERATE];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    pop = [[Population alloc] initWithSize:&_bounds.size];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    [[NSColor blackColor] set];
    NSRectFill(_bounds);
    [pop run];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
