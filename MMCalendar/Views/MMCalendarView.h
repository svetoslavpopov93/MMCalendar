//
//  MMCalendarView.h
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/12/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCalendarTopBarView.h"
#import "MMCalendarScrollView.h"

@interface MMCalendarView : UIView

-(instancetype)initWithCurrentFrame:(CGRect)frame;
@property (strong, nonatomic) MMCalendarScrollView *scrollView;

@end
