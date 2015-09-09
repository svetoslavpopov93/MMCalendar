//
//  MMCalendarScrollVIewController.m
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/5/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "MMCalendarScrollView.h"

@interface MMCalendarScrollView()

@property (assign, nonatomic) NSInteger calendarColCount;
@property (assign, nonatomic) NSInteger globalCellSpacing;
@property (strong, nonatomic) NSMutableArray *visibleViews;
@property (strong, nonatomic) NSMutableArray *recycledViews;
@property (assign, nonatomic) CGFloat lastContentOffset;
@property (nonatomic) CGFloat upperIndex;
@property (nonatomic) CGFloat bottomIndex;
@property (nonatomic) CGFloat currentUpperIndex;
@property (nonatomic) CGFloat currentBottomIndex;
@property (nonatomic) MMDirectionIdentifier direction;
@property (nonatomic) CGFloat cellSize;
@property (nonatomic) CGFloat bufferSize;
@property (nonatomic) CGSize initialSizeForSelf;

@property (strong, nonatomic) UILabel *yearLabel;
@property (assign, nonatomic) NSInteger currentYear;
@property (strong, nonatomic) NSDate *currentWeekMonday;
@property (nonatomic) NSInteger todaysWeekNumber;
@property (nonatomic) NSInteger upperWeekCounter;
@property (nonatomic) NSInteger bottomWeekCounter;

@end

@implementation MMCalendarScrollView

-(instancetype)init{
    self = [super init];
    
    if(self){
        // Set date management properties and values
        _upperWeekCounter = -5;
        _bottomWeekCounter = -6;
        
        NSDate *currentDate  = [NSDate date];
        NSCalendar *gregorianCalendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [gregorianCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        
        NSDateComponents *components = [gregorianCalendar components:(NSCalendarUnitYear| NSCalendarUnitMonth
                                                                      | NSCalendarUnitDay| NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth)  fromDate:currentDate];
        
        NSDateComponents *dt=[[NSDateComponents alloc]init];
        [dt setWeekOfMonth:[components weekOfMonth]];
        [dt setWeekday:2];
        [dt setMonth:[components month]];
        [dt setYear:[components year]];
        _currentWeekMonday = [gregorianCalendar dateFromComponents:dt];
        
        // Set views management properties and values
        _recycledViews = [[NSMutableArray alloc] init];
        _visibleViews = [[NSMutableArray alloc] init];
        _direction = MMDirectionNotDetermined;
        
        // Set year label
        _currentYear = [components year];
        _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 250, 100)];
        [_yearLabel setText:[NSString stringWithFormat:@"%ld", _currentYear]];
        [_yearLabel setFont:[_yearLabel.font fontWithSize:_yearLabel.frame.size.height/1.5]];
        [_yearLabel setEnabled:NO];
        _yearLabel.layer.masksToBounds = NO;
        _yearLabel.layer.cornerRadius = 8;
        _yearLabel.layer.shadowOffset = CGSizeMake(-15, 20);
        _yearLabel.layer.shadowRadius = 5;
        _yearLabel.layer.shadowOpacity = 0.5;
        [self addSubview:_yearLabel];
        
        self.delegate = self;
    }
    
    return self;
}

-(void)awakeFromNib{
    // Set date management properties and values
    _upperWeekCounter = -5;
    _bottomWeekCounter = -6;
    
    NSDate *currentDate  = [NSDate date];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorianCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    NSDateComponents *components = [gregorianCalendar components:(NSCalendarUnitYear| NSCalendarUnitMonth
                                                                  | NSCalendarUnitDay| NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth)  fromDate:currentDate];
    
    NSDateComponents *dt=[[NSDateComponents alloc]init];
    [dt setWeekOfMonth:[components weekOfMonth]];
    [dt setWeekday:2];
    [dt setMonth:[components month]];
    [dt setYear:[components year]];
    _currentWeekMonday = [gregorianCalendar dateFromComponents:dt];
    
    // Set views management properties and values
    _recycledViews = [[NSMutableArray alloc] init];
    _visibleViews = [[NSMutableArray alloc] init];
    _direction = MMDirectionNotDetermined;
    
    // Set year label
    _currentYear = [components year];
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 250, 100)];
    [_yearLabel setText:[NSString stringWithFormat:@"%ld", _currentYear]];
    [_yearLabel setFont:[_yearLabel.font fontWithSize:_yearLabel.frame.size.height/1.5]];
    [_yearLabel setEnabled:NO];
    _yearLabel.layer.masksToBounds = NO;
    _yearLabel.layer.cornerRadius = 8;
    _yearLabel.layer.shadowOffset = CGSizeMake(-15, 20);
    _yearLabel.layer.shadowRadius = 5;
    _yearLabel.layer.shadowOpacity = 0.5;
    [self addSubview:_yearLabel];
    
    self.delegate = self;
    
}

#pragma mark -
#pragma mark Calendar Views Management

-(void)applyInitialCalendarViews{
    self.upperIndex = 0;
    self.bottomIndex = CGFLOAT_MAX;
    
    [self addAllRowsForFirstLoad];
    [self performSelector:@selector(hideYearLabel) withObject:nil afterDelay:1.0];
}

-(void)addAllRowsForFirstLoad{
    CGFloat contentHeight = [self contentSize].height;
    CGFloat centerOffsetY = (contentHeight - self.initialSizeForSelf.height) / 2.0;
    
    [self setContentOffset:CGPointMake(0.0, centerOffsetY)];
    
    self.upperIndex = centerOffsetY;
    self.bottomIndex = self.upperIndex;
    self.currentUpperIndex = self.upperIndex;
    
    while (self.currentUpperIndex - self.cellSize - self.globalCellSpacing >= self.upperIndex - self.bufferSize) {
        
        self.upperWeekCounter--;
        self.currentUpperIndex = self.currentUpperIndex - (self.cellSize + self.globalCellSpacing);
        
        [self addRowForWeek:self.upperWeekCounter position:CGPointMake(self.globalCellSpacing, self.currentUpperIndex)];
        
    }
    
    self.upperIndex = self.currentUpperIndex;
    self.currentBottomIndex = self.bottomIndex;
    
    while (self.currentBottomIndex + self.globalCellSpacing + self.cellSize <= self.bottomIndex + self.bufferSize + self.initialSizeForSelf.height) {
        self.bottomWeekCounter++;
        [self addRowForWeek:self.bottomWeekCounter position:CGPointMake(self.globalCellSpacing, self.currentBottomIndex)];
        
        self.currentBottomIndex = self.currentBottomIndex + self.globalCellSpacing + self.cellSize;
    }
    
    self.bottomIndex = self.currentBottomIndex;
    
    self.currentUpperIndex = self.upperIndex;
    self.currentBottomIndex = self.bottomIndex;
}

-(void)addRowForWeek:(NSInteger)week position:(CGPoint)position{
    NSInteger numberOfDaysFromToday = week * 7;
    NSDate *firstDayOfTheCurrentWeek = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:numberOfDaysFromToday toDate:self.currentWeekMonday options:0];
    
    for (NSInteger index = 0; index < self.calendarColCount; index++) {
        NSDate *currentWeekDay = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:index toDate:firstDayOfTheCurrentWeek options:0];
        
        if (index == self.calendarColCount - 1 || index == self.calendarColCount - 2) {
            [self addDayForDate:currentWeekDay position:CGPointMake(self.globalCellSpacing + (index * self.cellSize) + (self.globalCellSpacing * index), position.y) isWeekDay: NO];
        }
        else {
            [self addDayForDate:currentWeekDay position:CGPointMake(self.globalCellSpacing + (index * self.cellSize) + (self.globalCellSpacing * index), position.y) isWeekDay: YES];
        }
    }
}

-(void)addDayForDate:(NSDate*)date position:(CGPoint)position isWeekDay:(BOOL)isWeekDay{
    MMCalendarCellView *view = [self dequeueRecycledView];
    
    if (!view) {
        view = [[MMCalendarCellView alloc] init];
        view.delegate = self;
    }
    
    CGRect calendarViewFrame = CGRectMake(position.x, position.y, self.cellSize, self.cellSize);
    [view setFrame:calendarViewFrame];
    
    NSDateComponents *dayMonthYearComponentsForDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDateComponents *dayMonthYearComponentsForToday = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    if ([dayMonthYearComponentsForDate year] != self.currentYear) {
        self.currentYear = [dayMonthYearComponentsForDate year];
        [self.yearLabel setText:[NSString stringWithFormat:@"%ld", self.currentYear]];
    }
    
    [view setBackgroundColor:[UIColor clearColor]];
    
    if (!isWeekDay) {
        [view setBackgroundColor:[UIColor colorWithRed:0.011f green:0.123f blue:0.221f alpha:0.05f]];
    }
    
    if (!([dayMonthYearComponentsForDate day] != [dayMonthYearComponentsForToday day] ||
          [dayMonthYearComponentsForDate month] != [dayMonthYearComponentsForToday month] ||
          [dayMonthYearComponentsForDate year] != [dayMonthYearComponentsForToday year])) {
        
        [view setBackgroundColor:[UIColor grayColor]];
        
    }
    
    [view setDate:date];
    [self.visibleViews addObject:view];
    
    [self insertSubview:view aboveSubview:self.yearLabel];
}

-(MMCalendarCellView *)dequeueRecycledView{
    MMCalendarCellView *view = [self.recycledViews firstObject];
    if (view) {
        [self.recycledViews removeObject:view];
    }
    
    return view;
}

-(void)hideYearLabel{
    [self.yearLabel setEnabled:NO];
    _yearLabel.layer.shadowOpacity = 0.15;
}

-(void)showYearLabel{
    [self.yearLabel setEnabled:YES];
    _yearLabel.layer.shadowOpacity = 0.5;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.currentUpperIndex = [self contentOffset].y;
    self.currentBottomIndex = [self contentOffset].y + [self bounds].size.height;
    
    if (self.lastContentOffset > scrollView.contentOffset.y){
        [self showYearLabel];
        self.direction = MMDirectionDown;
        
        while ((self.upperIndex + self.bufferSize) - self.currentUpperIndex >= self.cellSize + self.globalCellSpacing) {
            self.upperWeekCounter--;
            self.bottomWeekCounter--;
            [self addRowForWeek:self.upperWeekCounter position:CGPointMake(0, self.upperIndex - (self.cellSize + self.globalCellSpacing))];
            self.upperIndex = self.upperIndex - (self.cellSize + self.globalCellSpacing);
            self.bottomIndex  = self.bottomIndex - (self.cellSize + self.globalCellSpacing);
        }
    }
    
    else if (self.lastContentOffset < scrollView.contentOffset.y){
        [self showYearLabel];
        self.direction = MMDirectionUp;
        
        while ((self.currentBottomIndex + self.bufferSize) - self.bottomIndex > self.cellSize + self.globalCellSpacing) {
            self.upperWeekCounter++;
            self.bottomWeekCounter++;
            [self addRowForWeek:self.bottomWeekCounter position:CGPointMake(0, self.bottomIndex)];
            self.upperIndex = self.upperIndex + (self.cellSize + self.globalCellSpacing);
            self.bottomIndex = self.bottomIndex + (self.cellSize + self.globalCellSpacing);
        }
    }
    
    self.lastContentOffset = scrollView.contentOffset.y;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self hideYearLabel];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self hideYearLabel];
}

#pragma mark -
#pragma mark Layout Views

-(void)recenterIfNecessary {
    CGPoint currentOffset = [self contentOffset];
    CGFloat contentHeight = [self contentSize].height;
    CGFloat centerOffsetY = (contentHeight - self.initialSizeForSelf
                             .height) / 2.0;
    CGFloat distanceFromCenter = fabs(currentOffset.y - centerOffsetY);
    
    if (distanceFromCenter > (contentHeight / 3.0)) {
        
        if (self.direction == MMDirectionDown) {
            self.upperIndex = self.upperIndex + distanceFromCenter;
            self.bottomIndex = self.bottomIndex + distanceFromCenter;
            self.lastContentOffset = self.contentOffset.y + distanceFromCenter;
        }
        else{
            self.upperIndex = self.upperIndex - distanceFromCenter;
            self.bottomIndex = self.bottomIndex - distanceFromCenter;
            self.lastContentOffset = self.contentOffset.y - distanceFromCenter;
            
        }
        
        self.contentOffset = CGPointMake(currentOffset.x, centerOffsetY);
        
        for (MMCalendarCellView *view in self.visibleViews) {
            CGPoint center = view.center;
            center.y += centerOffsetY - currentOffset.y;
            view.center = center;
        }
    }
}

-(void)recenterYearLabel{
    CGPoint currentOffset = [self contentOffset];
    CGPoint currentCoordinates = self.yearLabel.frame.origin;
    CGSize currentFrame = self.yearLabel.frame.size;
    
    CGRect repositionedFrame = CGRectMake(currentCoordinates.x, currentOffset.y + 70, currentFrame.width, currentFrame.height);
    [self.yearLabel setFrame:repositionedFrame];
}

-(void)checkIfRowIsOutOfScreen{
    for (MMCalendarCellView *view in self.visibleViews) {
        CGFloat maxY =(CGRectGetMaxY(view.frame));
        CGFloat minY = (CGRectGetMinY(view.frame));
        
        if (maxY > [self contentOffset].y + self.initialSizeForSelf.height + self.bufferSize || minY < [self contentOffset].y - self.bufferSize) {
            [view removeFromSuperview];
            [self.recycledViews addObject:view];
        }
    }
    
    for (MMCalendarCellView *view in self.recycledViews) {
        [self.visibleViews removeObject:view];
    }
}

-(void)setupCalendarViewWithSize: (CGSize)size columnCount:(NSInteger)columnCount globalCellSpacing:(NSInteger)globalSpacing{
    self.initialSizeForSelf = size;
    self.self.bufferSize = size.height / 3;
    self.cellSize = ((size.width - ((columnCount + 1) * globalSpacing)) / columnCount);
    self.contentSize = CGSizeMake(size.width, 5000);
    
    self.globalCellSpacing = globalSpacing;
    self.calendarColCount = columnCount;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self checkIfRowIsOutOfScreen];
    [self recenterYearLabel];
    [self recenterIfNecessary];
}

#pragma mark -
#pragma mark MMCalendarCellView delegate

-(void)calendarCellWasTapped:(MMCalendarCellView *)cell{
    
    [[self scrollViewDelegate] calendarCellDidOpen:cell];
    
}

@end
