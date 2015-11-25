//
//  SectionCellView.h
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/2/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SVPSectionView;
@protocol SVPSectionViewProtocol <NSObject>

@required
-(void)sectionWillResize:(SVPSectionView*)section;

@end

@interface SVPSectionView : UIView
@property (weak, nonatomic) id<SVPSectionViewProtocol> delegate;
@property (assign, nonatomic) NSInteger sectionElementsCount;
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;

- (instancetype)initWithSectionElements:(NSArray*)sectionElements;
- (void) setHeightConstraintConstant: (CGFloat)constant;
@end
