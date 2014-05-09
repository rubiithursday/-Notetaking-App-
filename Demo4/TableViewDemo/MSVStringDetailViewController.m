//
//  MSVStringDetailViewController.m
//  TableViewDemo
//
//  Created by Michael Vitrano on 4/15/14.
//  Copyright (c) 2014 Vitrano. All rights reserved.
//

#import "MSVStringDetailViewController.h"

@interface MSVStringDetailViewController ()

@property (nonatomic, strong) NSString *string;
@property (nonatomic) NSInteger row;

@property (weak, nonatomic) IBOutlet UITextView *textView;

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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = [NSString stringWithFormat:@"%d", self.row];
    
    self.textView.text = self.string;
}

@end
