//
//  MMCalendarTopBarView.m
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/12/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "MMCalendarTopBarView.h"

@interface MMCalendarTopBarView ()

@property (assign, nonatomic) NSInteger columnCount;
@property (assign, nonatomic) NSInteger globalCellSpacing;

@end

@implementation MMCalendarTopBarView

-(instancetype)initWithColumnCount:(NSInteger)columnCount globalCellSpacing:(NSInteger)globalCellSpacing{
    self = [super init];
    
    if(self){
        _columnCount = columnCount;
        _globalCellSpacing = globalCellSpacing;
    }
    
    return self;
}

-(void)setupSubviewsWithColumnCount:(NSInteger)columnCount globalCellSpacing:(NSInteger)globalCellSpacing{
    NSArray *daysInTheWeek = @[@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun"];
    
    for (NSInteger index = 0; index < columnCount; index++) {
        UILabel *weekDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [weekDayLabel setNumberOfLines:1];
        [weekDayLabel setFont:[weekDayLabel.font fontWithSize:weekDayLabel.font.lineHeight]];
        [weekDayLabel setText:[daysInTheWeek objectAtIndex:index]];
        [weekDayLabel setTextAlignment:NSTextAlignmentCenter];
        [weekDayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self addSubview:weekDayLabel];
        
    }
    
    [[self.subviews objectAtIndex: self.subviews.count - 1] setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:[self.subviews objectAtIndex: self.subviews.count - 1]
                                                                          attribute:NSLayoutAttributeTrailing
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1
                                                                           constant:0];
    
    [self addConstraint:trailingConstraint];
    
    
    for (NSInteger index = 0; index < self.subviews.count; index++) {
        UILabel *weekDayLabel = [[self subviews] objectAtIndex:index];
        [weekDayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSLayoutConstraint *leftConstraint;
        UIView *previousElement;
        
        if (index == 0) {
            leftConstraint = [NSLayoutConstraint constraintWithItem:weekDayLabel
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1
                                                           constant:8];
            
        }
        else{
            leftConstraint = [NSLayoutConstraint constraintWithItem:weekDayLabel
                                                                              attribute:NSLayoutAttributeLeading
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:[[self subviews] objectAtIndex:index - 1]
                                                                              attribute:NSLayoutAttributeTrailing
                                                                             multiplier:1
                                                                               constant:0];
        }
        
        NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[weekDayLabel]-|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"weekDayLabel" : weekDayLabel}];
        
        if (index != 0) {
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:[[self subviews] objectAtIndex:index - 1]
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                  toItem:weekDayLabel
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1
                                                                                constant:0];
            
            [self addConstraint:widthConstraint];
        }
        
        [self addConstraints:verticalConstraints];
        [self addConstraint:leftConstraint];
    }
}

@end
