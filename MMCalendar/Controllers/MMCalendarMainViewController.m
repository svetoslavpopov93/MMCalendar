//
//  MMCalendarMainViewController.m
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/5/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "MMCalendarMainViewController.h"

@interface MMCalendarMainViewController ()

@property (nonatomic, strong) MMCalendarCellView *currentCell;

@end

@implementation MMCalendarMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    MMCalendarView *view = [[MMCalendarView alloc] initWithCurrentFrame:self.view.frame];
    [self.view addSubview:view];
    view.scrollView.scrollViewDelegate = self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    MMAddNewEventViewController *popup = [segue destinationViewController];
    popup.cell = self.currentCell;
    [self setPresentationStyleForSelfController:self presentingController:popup];
}

-(void)calendarCellDidOpen:(MMCalendarCellView *)cell{
    [cell setBackgroundColor:[UIColor redColor]];
    self.currentCell = cell;
    
    [self performSegueWithIdentifier:@"addEventSegue" sender:self];
}

- (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    
    presentingController.providesPresentationContextTransitionStyle = YES;
    presentingController.definesPresentationContext = YES;
    
    [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
}

@end
