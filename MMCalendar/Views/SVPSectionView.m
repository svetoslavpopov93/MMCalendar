//
//  SectionCellView.m
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/2/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "SVPSectionView.h"
#import "SVPSectionHeaderCellView.h"
#import "SVPSectionCellView.h"
#import "SVPConstants.h"

@interface SVPSectionView() <SVPSectionHeaderCellViewProtocol>
@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) CGFloat separatorHeight;
@end

@implementation SVPSectionView

- (instancetype)initWithSectionElements:(NSArray*)sectionElements {
    self = [super init];
    
    if (self) {
        _separatorHeight = 1.0f;
        _sectionElementsCount = 0;
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:0
                                                        multiplier:1
                                                          constant:sectionBaseHeight];
        [self addConstraint:_heightConstraint];
        [self addSectionViews:sectionElements];

    }
    
    return self;
}

- (void) setHeightConstraintConstant: (CGFloat)constant{
    [self.heightConstraint setConstant:constant];
}

- (void)addSectionViews:(NSArray*)sectionElements {
    if ([sectionElements count] > 0) {
        UIView *headerCellContentView = [sectionElements objectAtIndex:0];
        SVPSectionHeaderCellView *headerCellContainer = [[SVPSectionHeaderCellView alloc] initWithContentView:headerCellContentView];
        
        headerCellContainer.delegate = self;
        
        [self addSubview:headerCellContainer];
        self.sectionElementsCount++;
        
        UIView *previousElement = headerCellContainer;
        
        for (NSInteger index = 1; index < [sectionElements count]; index++) {
            UIView *cell =[sectionElements objectAtIndex:index];
            
            SVPSectionCellView *sectionCell = [[SVPSectionCellView alloc] init];
            
            [sectionCell.contentView addSubview:cell];
            
            [self insertSubview:sectionCell belowSubview:headerCellContainer];
            [self setupSectionCellConstraints:sectionCell fromPreviousView:previousElement];
            
            self.sectionElementsCount++;
            previousElement = sectionCell;
        }
    }
}

- (void)setupSectionCellConstraints:(SVPSectionCellView*)cell fromPreviousView:(UIView*)previousElement {
    [cell setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:cell
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:previousElement
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1.0f
                                                                         constant:0.0f];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:cell
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:previousElement
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1.0f
                                                                         constant:0.0f];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:cell
                                                                        attribute:NSLayoutAttributeTrailing
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:previousElement
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1.0f
                                                                         constant:0.0f];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:cell
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:previousElement
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0f
                                                                         constant:sectionBaseHeight * -1];
    
    [self addConstraint:heightConstraint];
    [self addConstraint:leadingConstraint];
    [self addConstraint:trailingConstraint];
    [cell setTopConstraint:topConstraint];
    [self addConstraint:[cell topConstraint]];
}

-(void)userDidTapOnHeader{
    [self.delegate sectionWillResize:self];
}

@end

#warning TODO: Fix separator height on every place
