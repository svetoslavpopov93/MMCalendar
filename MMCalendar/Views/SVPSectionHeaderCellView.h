//
//  SVPSectionHeaderCellView.h
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/4/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SVPSectionHeaderCellViewProtocol <NSObject>

@required
- (void)userDidTapOnHeader;

@end

@interface SVPSectionHeaderCellView : UIView

@property (assign, nonatomic) CGFloat separatorHeight;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *title;
@property (weak, nonatomic) id<SVPSectionHeaderCellViewProtocol> delegate;

- (instancetype)initWithContentView:(UIView*)contentView;
- (void)setupConstraints;

@end
