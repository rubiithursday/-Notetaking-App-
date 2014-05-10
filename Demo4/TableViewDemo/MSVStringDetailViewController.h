//
//  MSVStringDetailViewController.h
//  TableViewDemo
//
///  Created by Rubii Pham.
//  Copyright (c) 2014 Pham. All rights reserved.

//  Copyright (c) 2014 Vitrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHPNote.h"

@interface MSVStringDetailViewController : UIViewController

- (instancetype)initWithRow:(NSInteger)row string:(NSString *)string;
//- (instancetype)initWithNibName:(UIImage *)image;
- (instancetype)initWithRow:(NSInteger)row noteObj:(NHPNote *)note;

@end
