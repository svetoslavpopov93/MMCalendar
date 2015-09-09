//
//  MMEvent.h
//  MMCalendar
//
//  Created by Svetoslav Popov on 9/1/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMEvent : NSObject

@property (strong, nonatomic) NSString *eventName;
@property (strong, nonatomic) NSString *eventPlace;

- (instancetype)initWithEventName:(NSString*)eventName eventPlace:(NSString*)eventPlace eventNotes:(NSString*)eventNotes;

@end
