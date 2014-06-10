//
//  Population.h
//  coalsave
//
//  Created by Arman Bilge on 9/06/14.
//  Copyright (c) 2014 Computational Evolution Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Population : NSObject

@property NSMutableArray* pop;
@property NSSize* size;

- (id)initWithSize:(NSSize*)size;
- (void)run;

@end
