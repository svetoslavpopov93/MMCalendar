//
//  SVPSectionCellView.m
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/7/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "SVPSectionCellView.h"

@interface SVPSectionCellView()
@property (strong, nonatomic) UIView *separatorView;
@end

@implementation SVPSectionCellView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _separatorView = [[UIView alloc] init];
        _contentView = [[UIView alloc] init];
    
        [self addSubview:_separatorView];
        [self addSubview:_contentView];
        
        [_separatorView setBackgroundColor:[UIColor grayColor]];
        
        [self layoutIfNeeded];
    }
    return self;
}

- (void)layoutIfNeeded{
    [super layoutIfNeeded];
    
    [self setupConstraints];
}

- (void)setupConstraints {
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.separatorView setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSDictionary *views = NSDictionaryOfVariableBindings(_contentView, _separatorView);
    
    NSArray *horizontalConstraintsForContentView = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
                                                                                           options:0
                                                                                           metrics:nil
                                                                                             views:views];
    
    NSArray *horizontalConstraintsForSeparatorView = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_separatorView]|"
                                                                                             options:0
                                                                                             metrics:nil
                                                                                               views:views];
    NSArray *verticalConstraintsForContentViewAndSeparatorView = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView][_separatorView(1)]|"
                                                                                                         options:0
                                                                                                         metrics:nil
                                                                                                           views:views];
    [self addConstraints:horizontalConstraintsForContentView];
    [self addConstraints:horizontalConstraintsForSeparatorView];
    [self addConstraints:verticalConstraintsForContentViewAndSeparatorView];
}

@end
