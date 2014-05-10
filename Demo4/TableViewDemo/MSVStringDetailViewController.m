//
//  MSVStringDetailViewController.m
//  TableViewDemo
//
//  Created by Rubii Pham.
//  Copyright (c) 2014 Pham. All rights reserved.
//
//this has the string object and the photo object

#import "MSVStringDetailViewController.h"

@interface MSVStringDetailViewController ()

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NHPNote *rubiiNote;
@property (nonatomic) NSInteger row;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MSVStringDetailViewController

- (instancetype)initWithRow:(NSInteger)row string:(NSString *)string
{
    if (self = [self initWithNibName:@"MSVStringDetailViewController" bundle:nil]) {
        self.string = string;
        self.row = row;
    }
    return self;
}

- (instancetype)initWithRow:(NSInteger)row noteObj:(NHPNote *)note {
	if (self = [self initWithNibName:@"MSVStringDetailViewController" bundle:nil]) {
		self.rubiiNote = note;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.rubiiNote.title;
	
//	[NSString stringWithFormat:@"%d", self.row];
    self.textView.text = self.rubiiNote.note;
	if (self.rubiiNote.notePic) {
		self.imageView.image = self.rubiiNote.notePic;
	}
}

@end
