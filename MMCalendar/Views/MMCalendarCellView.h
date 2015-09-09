//
//  MMCalendarCellView.h
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/5/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMCalendarCellView;
@class MMEvent;

@protocol MMCalendarCellViewDelegate <NSObject>
@required
-(void)calendarCellWasTapped:(MMCalendarCellView*)cell;
@end

@interface MMCalendarCellView : UIView

@property (strong, nonatomic) NSDate *date;
@property (weak, nonatomic) id delegate;

-(void)addEvent:(MMEvent*)event;

@end
