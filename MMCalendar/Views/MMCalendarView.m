//
//  MMCalendarView.m
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/12/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "MMCalendarView.h"

static const NSInteger calendarColumnCount = 7;
static const NSInteger globalCellSpacing = 6;

@interface MMCalendarView ()

@end

@implementation MMCalendarView

-(instancetype)initWithCurrentFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _scrollView = [MMCalendarScrollView new];
        [_scrollView setupCalendarViewWithSize: frame.size columnCount:calendarColumnCount globalCellSpacing:globalCellSpacing];
        [_scrollView applyInitialCalendarViews];
        
        _scrollView.scrollViewDelegate = self;
        [self addSubview:_scrollView];
        
        [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint *scrollViewLeading = [NSLayoutConstraint constraintWithItem:_scrollView
                                                                             attribute:NSLayoutAttributeLeading
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self attribute:NSLayoutAttributeLeading
                                                                            multiplier:1
                                                                              constant:0];
        
        NSLayoutConstraint *scrollViewTop = [NSLayoutConstraint constraintWithItem:_scrollView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:0];
        
        NSLayoutConstraint *scrollViewTrailing = [NSLayoutConstraint constraintWithItem:_scrollView
                                                                          attribute:NSLayoutAttributeTrailing
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1
                                                                           constant:0];
        
        NSLayoutConstraint *scrollViewBottom = [NSLayoutConstraint constraintWithItem:_scrollView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1
                                                                             constant:0];
        
        [self addConstraint:scrollViewLeading];
        [self addConstraint:scrollViewTop];
        [self addConstraint:scrollViewTrailing];
        [self addConstraint:scrollViewBottom];
        
        MMCalendarTopBarView *topBar = [MMCalendarTopBarView new];
        [topBar setupSubviewsWithColumnCount:calendarColumnCount globalCellSpacing:globalCellSpacing];
        [topBar setBackgroundColor:[UIColor whiteColor]];
        [topBar setAlpha:0.95f];
        [self insertSubview:topBar aboveSubview:_scrollView];
        
        [topBar setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint *topBarLeading = [NSLayoutConstraint constraintWithItem:topBar
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self attribute:NSLayoutAttributeLeading
                                                                        multiplier:1
                                                                          constant:0];
        
        NSLayoutConstraint *topBarTop = [NSLayoutConstraint constraintWithItem:topBar
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0];
        
        NSLayoutConstraint *topBarTrailing = [NSLayoutConstraint constraintWithItem:topBar
                                                                          attribute:NSLayoutAttributeTrailing
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1
                                                                           constant:0];
        
        NSLayoutConstraint *topBarHeight = [NSLayoutConstraint constraintWithItem:topBar
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1
                                                                         constant:80];
        
        [self addConstraint: topBarLeading];
        [self addConstraint: topBarTop];
        [self addConstraint: topBarTrailing];
        [self addConstraint: topBarHeight];
        
        [_scrollView setDecelerationRate:UIScrollViewDecelerationRateNormal];
        
    }
    
    return self;
}


@end
