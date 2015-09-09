//
//  MMAddNewEventViewController.m
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/17/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "MMAddNewEventViewController.h"
#import "MMEvent.h"

@interface MMAddNewEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventName;
@property (weak, nonatomic) IBOutlet UITextField *eventLocation;
@property (weak, nonatomic) IBOutlet UITextView *eventNotes;

@end

@implementation MMAddNewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonActionAddEvent)];
    
    self.navigationItem.rightBarButtonItem = doneButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonActionCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonActionAddEvent{
    MMEvent *event = [[MMEvent alloc] initWithEventName:self.eventName.text eventPlace:self.eventLocation.text eventNotes:self.eventNotes.text];
    
    [self.cell addEvent:event];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
