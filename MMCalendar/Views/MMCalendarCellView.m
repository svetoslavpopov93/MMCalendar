//
//  MMCalendarCellView.m
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/5/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "MMCalendarCellView.h"
#import "MMEvent.h"

@interface MMCalendarCellView()

@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) NSMutableArray *events;

@end

@implementation MMCalendarCellView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _date = [NSDate new];
        _events = [[NSMutableArray alloc] init];
        [self initializeSubviews];
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        
    }
    return self;
}

-(void)awakeFromNib{
    
    [self initializeSubviews];
    
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 8;
    
}

-(void)setDate:(NSDate *)date{
    _date = date;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    [self.dayLabel setText:[NSString stringWithFormat:@"%ld", [components day]]];
    NSDateComponents *monthComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date];
    NSInteger monthIndex = [monthComponent month];

    NSDateFormatter *df = [NSDateFormatter new];
    NSString *monthString = [[[df monthSymbols] objectAtIndex:monthIndex - 1] substringToIndex:3];
    
    [self.monthLabel setText:monthString];
    
    [self initializeGestureRecognizer];
}


- (void)initializeSubviews {
    _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 25)];
    [_dayLabel setNumberOfLines:1];
    [_dayLabel setFont:[_dayLabel.font fontWithSize:_dayLabel.font.lineHeight + 3]];
    [_dayLabel setTextAlignment:NSTextAlignmentRight];
    
    _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 45, 25)];
    [_monthLabel setNumberOfLines:1];
    [_monthLabel setTextAlignment:NSTextAlignmentLeft];
    [_monthLabel setFont:[_monthLabel.font fontWithSize:_monthLabel.frame.size.height / 2.3]];
    [_monthLabel setTextColor:[UIColor blackColor]];
    
    [self addSubview:_dayLabel];
    [self addSubview:_monthLabel];
    
    [_dayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_monthLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *dayLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.dayLabel
                                                                                 attribute:NSLayoutAttributeLeading
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self
                                                                                 attribute:NSLayoutAttributeLeading
                                                                                multiplier:1
                                                                                  constant:3];
    
    NSLayoutConstraint *dayLabelTopConstraint = [NSLayoutConstraint constraintWithItem:self.dayLabel
                                                                                  attribute:NSLayoutAttributeTop
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self
                                                                                  attribute:NSLayoutAttributeTop
                                                                                 multiplier:1
                                                                                   constant:3];
    
    NSLayoutConstraint *dayLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                  attribute:NSLayoutAttributeTrailing
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.dayLabel
                                                                                  attribute:NSLayoutAttributeTrailing
                                                                                 multiplier:1
                                                                                   constant:3];
    
    NSLayoutConstraint *dayLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:self.dayLabel
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeHeight
                                                                               multiplier:0.5
                                                                                 constant:1];
    
    [self addConstraint:dayLabelLeadingConstraint];
    [self addConstraint:dayLabelTopConstraint];
    [self addConstraint:dayLabelTrailingConstraint];
    [self addConstraint:dayLabelHeightConstraint];
    
    NSLayoutConstraint *monthLabelWidthConstraint = [NSLayoutConstraint constraintWithItem:self.monthLabel
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self.dayLabel
                                                                                 attribute:NSLayoutAttributeWidth
                                                                                multiplier:0.65
                                                                                  constant:1];
    
    NSLayoutConstraint *monthLabelTopConstraint = [NSLayoutConstraint constraintWithItem:self.monthLabel
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.dayLabel
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1
                                                                                constant:1];
    
    NSLayoutConstraint *monthLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.monthLabel
                                                                                    attribute:NSLayoutAttributeTrailing
                                                                                   multiplier:1
                                                                                     constant:3];
    
    NSLayoutConstraint *monthLabelBottomConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.monthLabel
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1
                                                                                   constant:3];
    
    [self addConstraint:monthLabelWidthConstraint];
    [self addConstraint:monthLabelTopConstraint];
    [self addConstraint:monthLabelTrailingConstraint];
    [self addConstraint:monthLabelBottomConstraint];
}

-(void)addEvent:(MMEvent*)event{
    [self.events addObject:event];
}

-(void)initializeGestureRecognizer{
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleFingerTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [[self delegate] calendarCellWasTapped:self];
}

@end
