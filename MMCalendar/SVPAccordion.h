//
//  SVPAccordion.h
//  SVPAccordionView
//
//  Created by Svetoslav Popov on 9/2/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SVPAccordionDataSource <NSObject>

@required
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)sectionIndex;
- (UIView*)cellForRowAtIndexPath:(NSIndexPath*)indexPath;

@end

@protocol SVPAccordionDelegate <NSObject>

@optional
-(UIView*)viewForSectionHeaderAtIndex:(NSInteger)sectionIndex;
-(CGFloat)sizeForCellSeparator;
-(CGFloat)sizeForHeaderCellSeparator;

@end

@interface SVPAccordion : UIView

- (void)reloadAccordion;

@property id<SVPAccordionDataSource> datasource;
@property id<SVPAccordionDelegate> delegate;

@end
