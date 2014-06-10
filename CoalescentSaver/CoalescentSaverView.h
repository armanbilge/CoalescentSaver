//
//  CoalescentSaverView.h
//  CoalescentSaver
//
//  Created by Arman Bilge on 10/06/14.
//  Copyright (c) 2014 Computational Evolution Group. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

#import "Population.h"

@interface CoalescentSaverView : ScreenSaverView {
    @private
    Population* pop;
}

@end
