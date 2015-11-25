//
//  MMAddNewEventViewController.m
//  MMCalendar
//
//  Created by Svetoslav Popov on 8/17/15.
//  Copyright (c) 2015 Svetoslav Popov. All rights reserved.
//

#import "MMAddNewEventViewController.h"
#import "MMEvent.h"
#import "SVPAccordion.h"

@interface MMAddNewEventViewController ()

@property (strong, nonatomic) UITextField *eventName;
@property (strong, nonatomic) UITextField *eventLocation;
@property (strong, nonatomic) UITextView *eventNotes;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UITextField *activeField;

@end

@implementation MMAddNewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonActionAddEvent)];
    
    self.navigationItem.rightBarButtonItem = doneButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification 
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                                object:nil];
    
    [self addSubviews];
    
    [self setupConstraints];
   
}

#warning move methods
- (void)addSubviews{
    // scrollView
    self.scrollView = [UIScrollView new];
    [self.view addSubview:self.scrollView];
    
    // contentView
    self.contentView = [UIView new];
    [self.contentView setBackgroundColor:[UIColor purpleColor]];//temp
    [self.scrollView addSubview:self.contentView];
    
    // eventName
    self.eventName = [UITextField new];
    [self.eventName setBackgroundColor:[UIColor whiteColor]];//temp
    [self.contentView addSubview:self.eventName];
    
    // eventLocation
    self.eventLocation = [UITextField new];
    [self.eventLocation setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.eventLocation];
    
    // eventNotes
    self.eventNotes = [UITextView new];
    [self.eventNotes setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.eventNotes];
    
    
#warning Fix delegating part for text view and text fields
    
    
    
#warning TODO: add other subviews.
}

- (void)setupConstraints{
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.eventName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.eventLocation setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.eventNotes setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Setup scrollView constraints
    NSLayoutConstraint *scrollViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView
                                                                                   attribute:NSLayoutAttributeLeading
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.view
                                                                                   attribute:NSLayoutAttributeLeft
                                                                                  multiplier:1.0f
                                                                                    constant:0.0f];
    
    NSLayoutConstraint *scrollViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView
                                                                                   attribute:NSLayoutAttributeTop
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.view
                                                                                   attribute:NSLayoutAttributeTop
                                                                                  multiplier:1.0f
                                                                                    constant:0.0f];
    
    NSLayoutConstraint *scrollViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView
                                                                                   attribute:NSLayoutAttributeTrailing
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.view
                                                                                   attribute:NSLayoutAttributeTrailing
                                                                                  multiplier:1.0f
                                                                                    constant:0.0f];
    
    NSLayoutConstraint *scrollViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.view
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                  multiplier:1.0f
                                                                                    constant:0.0f];
    
    [self.view addConstraint:scrollViewLeadingConstraint];
    [self.view addConstraint:scrollViewTopConstraint];
    [self.view addConstraint:scrollViewTrailingConstraint];
    [self.view addConstraint:scrollViewBottomConstraint];
    
    // Setup contentView constraints
    NSLayoutConstraint *contentViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                   attribute:NSLayoutAttributeLeading
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.view
                                                                                   attribute:NSLayoutAttributeLeft
                                                                                  multiplier:1.0f
                                                                                    constant:0.0f];
    
    NSLayoutConstraint *contentViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                    attribute:NSLayoutAttributeTop
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.view
                                                                                    attribute:NSLayoutAttributeTop
                                                                                   multiplier:1.0f
                                                                                     constant:0.0f];
    
    NSLayoutConstraint *contentViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self.view
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                    multiplier:1.0f
                                                                                      constant:0.0f];
    
    NSLayoutConstraint *contentViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self.view
                                                                                     attribute:NSLayoutAttributeBottom
                                                                                    multiplier:1.0f
                                                                                      constant:0.0f];
    
    //[self.contentView addConstraint:contentViewHeightConstraint];
    [self.view addConstraint:contentViewLeadingConstraint];
    [self.view addConstraint:contentViewTopConstraint];
    [self.view addConstraint:contentViewTrailingConstraint];
    [self.view addConstraint:contentViewBottomConstraint];
    
    // Setup eventName constraints
    NSLayoutConstraint *eventNameLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.eventName
                                                                                  attribute:NSLayoutAttributeLeading
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.contentView
                                                                                  attribute:NSLayoutAttributeLeft
                                                                                 multiplier:1.0f
                                                                                   constant:20.0f];
    
    NSLayoutConstraint *eventNameTopConstraint = [NSLayoutConstraint constraintWithItem:self.eventName
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.contentView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1.0f
                                                                               constant:20.0f];
    
    NSLayoutConstraint *eventNameCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.eventName
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.contentView
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                 multiplier:1.0f
                                                                                   constant:0.0f];
    
    
    [self.contentView addConstraint:eventNameLeadingConstraint];
    [self.contentView addConstraint:eventNameTopConstraint];
    [self.contentView addConstraint:eventNameCenterXConstraint];
    
    // Setup eventLocation constraints
    NSLayoutConstraint *eventLocationLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.eventLocation
                                                                                  attribute:NSLayoutAttributeLeading
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.contentView
                                                                                  attribute:NSLayoutAttributeLeft
                                                                                 multiplier:1.0f
                                                                                   constant:20.0f];
    
    NSLayoutConstraint *eventLocationTopConstraint = [NSLayoutConstraint constraintWithItem:self.eventLocation
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.eventName
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0f
                                                                               constant:20.0f];
    
    NSLayoutConstraint *eventLocationCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.eventLocation
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.contentView
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                 multiplier:1.0f
                                                                                   constant:0.0f];
    
    
    [self.contentView addConstraint:eventLocationLeadingConstraint];
    [self.contentView addConstraint:eventLocationTopConstraint];
    [self.contentView addConstraint:eventLocationCenterXConstraint];
    
    // Setup eventNotes constraints
    NSLayoutConstraint *eventNotesHeightConstraint = [NSLayoutConstraint constraintWithItem:self.eventNotes
                                                                                  attribute:NSLayoutAttributeHeight
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:nil
                                                                                  attribute:0
                                                                                 multiplier:1.0f
                                                                                   constant:150.0f];
    
    NSLayoutConstraint *eventNotesLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.eventNotes
                                                                                      attribute:NSLayoutAttributeLeading
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:self.contentView
                                                                                      attribute:NSLayoutAttributeLeft
                                                                                     multiplier:1.0f
                                                                                       constant:20.0f];
    
    NSLayoutConstraint *eventNotesTopConstraint = [NSLayoutConstraint constraintWithItem:self.eventNotes
                                                                                  attribute:NSLayoutAttributeTop
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.eventLocation
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1.0f
                                                                                   constant:20.0f];
    
    NSLayoutConstraint *eventNotesCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.eventNotes
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.contentView
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                  multiplier:1.0f
                                                                                    constant:0.0f];
    
    [self.eventNotes addConstraint:eventNotesHeightConstraint];
    [self.contentView addConstraint:eventNotesLeadingConstraint];
    [self.contentView addConstraint:eventNotesTopConstraint];
    [self.contentView addConstraint:eventNotesCenterXConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender
{
    self.activeField = nil;
}

- (void)buttonActionCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonActionAddEvent{
    MMEvent *event = [[MMEvent alloc] initWithEventName:self.eventName.text eventPlace:self.eventLocation.text eventNotes:self.eventNotes.text];
    
    [self.cell addEvent:event];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0f, 0.0f, kbRect.size.height, 0.0f);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbRect.size.height;
//    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
//        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
//    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
