//
//  MMCalendarScrollView.h
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/12/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCalendarCellView.h"

typedef enum : NSUInteger {
    MMDirectionDown,
    MMDirectionUp,
    MMDirectionNotDetermined,
    MMDirectionDetermined,
} MMDirectionIdentifier;

@protocol MMScrollViewDelegate <NSObject>

@required
-(void)calendarCellDidOpen:(MMCalendarCellView*)cell;

@end

@interface MMCalendarScrollView : UIScrollView <UIScrollViewDelegate, MMCalendarCellViewDelegate>

@property (weak, nonatomic) id scrollViewDelegate;
-(void)setupCalendarViewWithSize: (CGSize)size columnCount:(NSInteger)columnCount globalCellSpacing:(NSInteger)globalCellSpacing;
-(void)applyInitialCalendarViews;

@end
