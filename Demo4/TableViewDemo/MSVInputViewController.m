//
//  MSVInputViewController.m
//  TableViewDemo
//
//  Created by Rubii Pham.
//  Copyright (c) 2014 Pham. All rights reserved.

//

#import "MSVInputViewController.h"
#import <MessageUI/MessageUI.h>
#import "NHPNote.h"
@interface MSVInputViewController () <UITextViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *longerTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveNoteButton;
@property (weak, nonatomic) IBOutlet UIButton *exitNoteButton;
@property (weak, nonatomic) IBOutlet UIButton *emailYourNoteButton;
@property (weak, nonatomic) NSString *helpText;

@end

@implementation MSVInputViewController

@synthesize userNote;

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
	
	self.userNote = [[NHPNote alloc] init];
    
    self.helpText = @"Tap to start typing your note";
    
    [self.saveNoteButton addTarget:self action:@selector(saveNoteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.exitNoteButton addTarget:self action:@selector(exitNoteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.emailYourNoteButton addTarget:self action:@selector(emailYourNoteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.longerTextField.delegate = self;
    self.longerTextField.backgroundColor = [UIColor whiteColor];
    self.longerTextField.editable = YES;
    self.longerTextField.text = self.helpText;
    self.longerTextField.textColor = [UIColor lightGrayColor];
}

- (void)saveNoteButtonPressed:(UIButton *)saveNoteButton {
	NSString *hackyTitle = [NSString stringWithString:self.longerTextField.text];
	self.userNote.title = [hackyTitle componentsSeparatedByString:@"\n"][0];
	self.userNote.note = self.longerTextField.text;
	[self.delegate inputController:self didFinishWithRubiiNote:self.userNote];
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

@synthesize imageView,choosePhotoBtn, takePhotoBtn;

-(IBAction) getPhoto:(id) sender {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	
	if((UIButton *) sender == choosePhotoBtn) {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
	
	[self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	self.userNote.notePic = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//	UIImage *myImage = [UIImage imageNamed:@"my_bundled_image"];
//	NSData *myImageData = UIImagePNGRepresentation(picker);

	
}

- (IBAction)emailYourNoteButton:(UIButton *)sender
{
	MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
//	mailComposer.mailComposeDelegate = self;
	
	UIImage *myImage = [UIImage imageNamed:@"imageToSave"];
	NSData *myImageData = UIImagePNGRepresentation(myImage);
	[mailComposer addAttachmentData:myImageData mimeType:@"image/png" fileName:@"imageToSave"];
	
//	UIImage *imageToSave = [UIImage imageWithContentsOfFile: *imagePath];
	//    NSData *imageData = UIImagePNGRepresentation(myImage);
	//	[mailComposer addAttachmentData:imageData mimeType:@"image/png" fileName:@"image"];

	NSString *emailSubject = [NSString stringWithFormat:@"[NOTE] %@", [self.longerTextField.text componentsSeparatedByString:@"\n"][0]];
	NSString *emailBody = self.longerTextField.text;

	[mailComposer setSubject:emailSubject];
	[mailComposer setMessageBody:emailBody isHTML:NO];
	
//	mailComposer.modalPresentationStyle = UIModalPresentationPageSheet;
	
	[self presentViewController:mailComposer animated:NO completion:nil];
}

@end
