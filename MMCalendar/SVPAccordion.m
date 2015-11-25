//
//  SVPAccordion.m
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/2/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "SVPAccordion.h"
#import "SVPSectionView.h"
#import "SVPConstants.h"
#import "SVPSectionCellView.h"

@interface SVPAccordion()<SVPSectionViewProtocol>

@property (strong, nonatomic) UIScrollView *accordionScrollView;
@property (strong, nonatomic) UIView *accordionView;

@property (strong, nonatomic) UIView *previousElement;
@property (strong, nonatomic) NSArray *sections;
@property (assign, nonatomic) CGFloat separatorHeight;

@end

@implementation SVPAccordion

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sections = [[NSArray alloc] init];
        [self addSubviews];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _sections = [[NSArray alloc] init];
    [self addSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _sections = [[NSArray alloc] init];
        _separatorHeight = 1.0f;
        _accordionScrollView = [[UIScrollView alloc] init];
        [_accordionScrollView setScrollEnabled:YES];
        _accordionView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubviews];
    }
    return self;
}

#pragma mark - View management
- (void)addSubviews{
    [self.accordionView setBackgroundColor:[UIColor whiteColor]];
    [self.accordionScrollView addSubview:self.accordionView];
    [self addSubview:self.accordionScrollView];
    
    [self setAccordionConstraints];
}

- (void)setAccordionConstraints{
    // Setup accordionScrollView constraints
    [self.accordionScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *accordionScrollViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.accordionScrollView
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeLeading
                                                                        multiplier:1
                                                                          constant:0];
    NSLayoutConstraint *accordionScrollViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.accordionScrollView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0];
    NSLayoutConstraint *accordionScrollViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.accordionScrollView
                                                                          attribute:NSLayoutAttributeTrailing
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1
                                                                           constant:0];
        NSLayoutConstraint *accordionScrollViewbottomConstraint = [NSLayoutConstraint constraintWithItem:self.accordionScrollView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1
                                                                             constant:0];
    
    [self addConstraint:accordionScrollViewLeadingConstraint];
    [self addConstraint:accordionScrollViewTopConstraint];
    [self addConstraint:accordionScrollViewTrailingConstraint];
    [self addConstraint:accordionScrollViewbottomConstraint];
    
    // Setup accordionView constraints
    [self.accordionView setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSLayoutConstraint *accordionViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.accordionView
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.accordionScrollView
                                                                         attribute:NSLayoutAttributeLeading
                                                                        multiplier:1
                                                                          constant:0];
    NSLayoutConstraint *accordionViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.accordionView
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.accordionScrollView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:0];
    NSLayoutConstraint *accordionViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.accordionView
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.accordionScrollView
                                                                          attribute:NSLayoutAttributeWidth
                                                                         multiplier:1
                                                                           constant:0];
    NSLayoutConstraint *accordionViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.accordionView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.accordionScrollView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:0];
    
    [self.accordionScrollView addConstraint:accordionViewLeadingConstraint];
    [self.accordionScrollView addConstraint:accordionViewTopConstraint];
    [self.accordionScrollView addConstraint:accordionViewTrailingConstraint];
    [self.accordionScrollView addConstraint:accordionViewBottomConstraint];
 }

- (void) reloadAccordion{    
    for (NSInteger index = 0; index < [self getNumberOfSections]; index++) {
        NSMutableArray *sectionElementsArray = [NSMutableArray new];
        [sectionElementsArray addObject:[self getViewForSectionHeaderAtIndex:index]];
       
        NSInteger numberOfRows = [self getNumberOfRowsInSection:index];
        
        for (NSInteger rowIndex = 0; rowIndex < numberOfRows; rowIndex++) {
            [sectionElementsArray addObject: [self getCellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:index]]];
        }
        
        SVPSectionView *sectionCell = [[SVPSectionView alloc] initWithSectionElements:[NSArray arrayWithArray:sectionElementsArray]];
        sectionCell.delegate = self;
        
        [self.accordionView addSubview:sectionCell];
        
        [sectionCell setHeightConstraintConstant:CGRectGetHeight([[sectionElementsArray lastObject] frame])];
        [self setupSectionCellConstraints:sectionCell index:index];
        
        self.previousElement = sectionCell;
    }
}

- (void)setupSectionCellConstraints:(SVPSectionView*)sectionCell index:(NSInteger)index{
    
    NSLayoutConstraint *sectionCellWidthConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                                  attribute:NSLayoutAttributeWidth
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:0
                                                                                 multiplier:1
                                                                                   constant:CGRectGetWidth(self.accordionView.frame)];
    
    
    NSLayoutConstraint *sectionCellLeadingConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.accordionView
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                   multiplier:1
                                                                                     constant:0];
    
    NSLayoutConstraint *sectionCellTopConstraint;
    if (index == 0) {
        self.previousElement = self.accordionView;
        sectionCellTopConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.previousElement
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
    } else{
        sectionCellTopConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.previousElement
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:0];
    }
    
    NSLayoutConstraint *sectionCellTrailingConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self.accordionView
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                    multiplier:1
                                                                                      constant:0];
    if (index == [self getNumberOfSections] - 1) {
        NSLayoutConstraint *sectionCellBottomConstraint = [NSLayoutConstraint constraintWithItem:sectionCell
                                                                                       attribute:NSLayoutAttributeBottom
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self.accordionView
                                                                                       attribute:NSLayoutAttributeBottom
                                                                                      multiplier:1
                                                                                        constant:0];
        
        [self.accordionView addConstraint:sectionCellBottomConstraint];
    }
    
    
    
    
    [sectionCell addConstraint:sectionCellWidthConstraint];
    [self.accordionView addConstraint:sectionCellLeadingConstraint];
    [self.accordionView addConstraint:sectionCellTopConstraint];
    [self.accordionView addConstraint:sectionCellTrailingConstraint];
}

#pragma mark - Calculations
- (CGFloat)sectionHeightAtIndex:(NSInteger)index{
    CGFloat height = 0.0f;
    NSIndexPath *currentIndexPath;
    
    height = height + CGRectGetHeight([[self getViewForSectionHeaderAtIndex:index] frame]) + [self getSizeForCellSeparator];
    
    for (NSInteger rowIndex = 0; rowIndex < [self getNumberOfRowsInSection:index]; rowIndex++) {
        currentIndexPath = [NSIndexPath indexPathForRow:rowIndex inSection:index];
        
        height = height + CGRectGetHeight([[self getCellForRowAtIndexPath:currentIndexPath] frame]);
    }

    return height;
}

#pragma mark - Datasource
- (NSInteger)getNumberOfSections{
    return [self.datasource numberOfSections];
}

- (NSInteger)getNumberOfRowsInSection:(NSInteger)sectionIndex{
    return [self.datasource numberOfRowsInSection:sectionIndex];
}

- (UIView*)getCellForRowAtIndexPath:(NSIndexPath*)indexPath{
    return [self.datasource cellForRowAtIndexPath:indexPath];
}

#pragma mark - Delegate
- (UIView*)getViewForSectionHeaderAtIndex:(NSInteger)sectionIndex{
    if ([self.delegate respondsToSelector:@selector(getViewForSectionHeaderAtIndex:)]) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.accordionView.frame), 40)];
    }
    
    return [self.delegate viewForSectionHeaderAtIndex:sectionIndex];
}

- (CGFloat)getSizeForCellSeparator{
    if ([self.delegate respondsToSelector:@selector(sizeForCellSeparator)]) {
        return [self.delegate sizeForCellSeparator];
    }
    
    return 0.0f;
}

-(CGFloat)getSizeForHeaderCellSeparator{
    if ([self.delegate respondsToSelector:@selector(sizeForHeaderCellSeparator)]) {
        return [self.delegate sizeForHeaderCellSeparator];
    }
    
    return 0.0f;
}

#pragma mark - SVPSectionViewProtocol
-(void)sectionWillResize:(SVPSectionView *)section{
    for (id sectionCell in self.accordionView.subviews) {
        if ( [sectionCell isKindOfClass:[SVPSectionView class]] ) {
            // Close all taps that are not tapped
            CGFloat sectionHeight;
            
            if (!(sectionCell == section)) {
                sectionHeight = sectionBaseHeight;
                [sectionCell setHeightConstraintConstant:sectionHeight];
                
                for (id sectionElement in [(SVPSectionView*)sectionCell subviews]) {
                    if ([sectionElement isKindOfClass:[SVPSectionCellView class]]) {
                        [[(SVPSectionCellView*)sectionElement topConstraint] setConstant:[[sectionCell heightConstraint] constant] * -1];
                    }
                }
                
                [UIView animateWithDuration:0.5f animations:^{
                    [self layoutIfNeeded];
                }];
            } else {
                // Expand on tap
                sectionHeight = section.heightConstraint.constant;
                
                if (sectionHeight <= sectionBaseHeight) {
                    sectionHeight = sectionBaseHeight * section.sectionElementsCount;
                    [section setHeightConstraintConstant:sectionHeight];
                    
                    for (id sectionElement in [(SVPSectionView*)sectionCell subviews]) {
                        if ([sectionElement isKindOfClass:[SVPSectionCellView class]]) {
                            [[(SVPSectionCellView*)sectionElement topConstraint] setConstant:0.0f];
                        }
                    }

                    [UIView animateWithDuration:0.5f animations:^{
                        [self layoutIfNeeded];
                    }];
                } else{
                    // Close tapped section if expanded
                    sectionHeight = sectionBaseHeight;
                    [section setHeightConstraintConstant:sectionHeight];
                    
                    for (id sectionElement in [(SVPSectionView*)sectionCell subviews]) {
                        if ([sectionElement isKindOfClass:[SVPSectionCellView class]]) {
                            [[(SVPSectionCellView*)sectionElement topConstraint] setConstant:[[sectionCell heightConstraint] constant] * -1];
                        }
                    }
                    
                    [UIView animateWithDuration:0.5f animations:^{
                        [self layoutIfNeeded];
                    }];
                }
            }
        }
    }
}

@end
