//
//  MMEvent.m
//  MMCalendar
//
//  Created by Svetoslav Popov on 9/1/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "MMEvent.h"

@implementation MMEvent

- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (instancetype)initWithEventName:(NSString*)eventName eventPlace:(NSString*)eventPlace eventNotes:(NSString*)eventNotes
{
    self = [self init];
    
    if (self) {
        self.eventName = eventName;
        self.eventPlace = eventPlace;
    }
    
    return self;
}

@end
