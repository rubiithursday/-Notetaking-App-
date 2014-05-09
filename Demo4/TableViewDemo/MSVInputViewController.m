//
//  MSVInputViewController.m
//  TableViewDemo
//
//  Created by Michael Vitrano on 4/15/14.
//  Copyright (c) 2014 Vitrano. All rights reserved.
//

#import "MSVInputViewController.h"

@interface MSVInputViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *longerTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveNoteButton;
@property (weak, nonatomic) IBOutlet UIButton *exitNoteButton;
@property (weak, nonatomic) NSString *helpText;

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
    
    self.helpText = @"Tap to start typing your note";
    
    [self.saveNoteButton addTarget:self action:@selector(saveNoteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.exitNoteButton addTarget:self action:@selector(exitNoteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.longerTextField.delegate = self;
    self.longerTextField.backgroundColor = [UIColor whiteColor];
    self.longerTextField.editable = YES;
    self.longerTextField.text = self.helpText;
    self.longerTextField.textColor = [UIColor lightGrayColor];
    

    [self.textField addTarget:self
                       action:@selector(textFieldDidFinish:)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    self.textField.returnKeyType = UIReturnKeyDone;
    
}

- (void)saveNoteButtonPressed:(UIButton *)saveNoteButton {
    [self.delegate inputController:self didFinishWithText:self.longerTextField.text];
}

- (void)exitNoteButtonPressed:(UIButton *)exitButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// automatically dismiss help text on edit
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.helpText]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

// show help text if text view is empty
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = self.helpText;
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
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
