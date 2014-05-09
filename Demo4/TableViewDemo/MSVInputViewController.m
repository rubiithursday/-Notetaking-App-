//
//  MSVInputViewController.m
//  TableViewDemo
//
//  Created by Michael Vitrano on 4/15/14.
//  Copyright (c) 2014 Vitrano. All rights reserved.
//

#import "MSVInputViewController.h"

@interface MSVInputViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MSVInputViewController

- (instancetype)init
{
    if (self = [self initWithNibName:@"MSVInputViewController" bundle:nil]) {
        // more config here
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.textField addTarget:self
                       action:@selector(textFieldDidFinish:)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    self.textField.returnKeyType = UIReturnKeyDone;
    
}


- (void)textFieldDidFinish:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        [self.delegate inputController:self didFinishWithText:textField.text];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Warning!"
                                   message:@"You must have a non-empty string to continue."
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil] show];
    }
}

@end
