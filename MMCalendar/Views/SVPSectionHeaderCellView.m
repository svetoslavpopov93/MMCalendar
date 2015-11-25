//
//  SVPSectionHeaderCellView.m
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/4/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "SVPSectionHeaderCellView.h"
#import "SVPConstants.h"

@interface SVPSectionHeaderCellView()
@property (strong, nonatomic) UIView *separatorView;
@end

@implementation SVPSectionHeaderCellView

-(void)layoutSubviews{
     [self setupConstraints];
}

- (instancetype)initWithContentView:(UIView*)contentView
{
    self = [super initWithFrame:contentView.frame];
    if (self) {
        _separatorHeight = 1.0f;
        _contentView = contentView;
        [_contentView setBackgroundColor:[UIColor whiteColor]];// temp
        
        _separatorView = [[UIView alloc] init];
        [_separatorView setBackgroundColor:[UIColor grayColor]];
        
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor blueColor];
        _title.backgroundColor=[UIColor clearColor];
        _title.textColor=[UIColor whiteColor];
        _title.userInteractionEnabled=NO;
        
        [_contentView addSubview:_title];
        
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleFingerTap];
        
        [self addSubviews];
    }

    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        _separatorHeight = 1.0f;
//        _contentView = [[UIView alloc] init];
//        [_contentView setBackgroundColor:[UIColor greenColor]];// temp
//        
//        _separatorView = [[UIView alloc] init];
//        [_separatorView setBackgroundColor:[UIColor grayColor]];
//        
//        _title = [[UILabel alloc] init];
//        _title.textColor = [UIColor blueColor];
//        _title.backgroundColor=[UIColor purpleColor];
//        _title.textColor=[UIColor whiteColor];
//        _title.userInteractionEnabled=NO;
//        _title.text= @"TEST"; // temp
//        [_contentView addSubview:_title];
//        
//        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//        [self addGestureRecognizer:singleFingerTap];
//        
//        [self addSubviews];
//    }
//    return self;
//}

- (void)addSubviews{
    [self addSubview:self.contentView];
    [self addSubview:self.separatorView];
}

- (void)setupConstraints{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.title setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *headerCellHeightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:0
                                                                       multiplier:1
                                                                         constant:sectionBaseHeight];
    
    NSLayoutConstraint *headerCellLeadingConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.superview
                                                                         attribute:NSLayoutAttributeLeading 
                                                                        multiplier:1
                                                                          constant:0];
    
    NSLayoutConstraint *headerCellTopConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.superview
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1
                                                                                constant:0];
    
    NSLayoutConstraint *headerCellTrailingConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                                    attribute:NSLayoutAttributeTrailing 
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.superview
                                                                                    attribute:NSLayoutAttributeTrailing 
                                                                                   multiplier:1
                                                                                     constant:0];
    [self addConstraint:headerCellHeightConstraint];
    [self.superview addConstraint:headerCellLeadingConstraint];
    [self.superview addConstraint:headerCellTopConstraint];
    [self.superview addConstraint:headerCellTrailingConstraint];
    
    // contentView constraints
    NSLayoutConstraint *contentViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                    attribute:NSLayoutAttributeLeading 
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self
                                                                                    attribute:NSLayoutAttributeLeading
                                                                                   multiplier:1
                                                                                     constant:0];
    
    NSLayoutConstraint *contentViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                attribute:NSLayoutAttributeTop
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeTop
                                                                               multiplier:1
                                                                                 constant:0];
    
    NSLayoutConstraint *contentViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                    multiplier:1
                                                                                      constant:0];
    
    NSLayoutConstraint *contentViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                   attribute:NSLayoutAttributeBottom 
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.separatorView
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                  multiplier:1
                                                                                    constant:0];
    // title constraints
    NSLayoutConstraint *titleCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.title
                                                                              attribute:NSLayoutAttributeCenterX 
                                                                              relatedBy:NSLayoutRelationEqual 
                                                                                 toItem:self.contentView
                                                                              attribute:NSLayoutAttributeCenterX 
                                                                             multiplier:1.0f
                                                                               constant:0.0f];
    
    NSLayoutConstraint *titleCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.title
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.contentView
                                                                              attribute:NSLayoutAttributeCenterY 
                                                                             multiplier:1.0f
                                                                               constant:0.0f];
    
    // separatorView constraints
    NSLayoutConstraint *separatorViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView
                                                                                     attribute:NSLayoutAttributeHeight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:nil
                                                                                     attribute:0
                                                                                    multiplier:1
                                                                                      constant:self.separatorHeight];
    
    NSLayoutConstraint *separatorViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView
                                                                                      attribute:NSLayoutAttributeLeading
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:self
                                                                                      attribute:NSLayoutAttributeLeading
                                                                                     multiplier:1
                                                                                       constant:0];
    
    NSLayoutConstraint *separatorViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self
                                                                                       attribute:NSLayoutAttributeTrailing
                                                                                      multiplier:1
                                                                                        constant:0];
    
    NSLayoutConstraint *separatorViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.separatorView
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                    multiplier:1
                                                                                      constant:0];
    
    [self addConstraint:contentViewLeadingConstraint];
    [self addConstraint:contentViewTopConstraint];
    [self addConstraint:contentViewTrailingConstraint];
    [self addConstraint:contentViewBottomConstraint];
    
    [self.contentView addConstraint:titleCenterXConstraint];
    [self.contentView addConstraint:titleCenterYConstraint];
    
    [self.separatorView addConstraint:separatorViewHeightConstraint];
    [self addConstraint:separatorViewLeadingConstraint];
    [self addConstraint:separatorViewTrailingConstraint];
    [self addConstraint:separatorViewBottomConstraint];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.delegate userDidTapOnHeader];
}


@end

