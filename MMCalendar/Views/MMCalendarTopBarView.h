//
//  MMCalendarTopBarView.h
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/12/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMCalendarTopBarView : UIView

-(void)setupSubviewsWithColumnCount:(NSInteger)columnCount globalCellSpacing:(NSInteger)globalCellSpacing;

@end
