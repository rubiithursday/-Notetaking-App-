//
//  MSVInputViewController.h
//  TableViewDemo
//
//  //  Created by Rubii Pham.
//  Copyright (c) 2014 Pham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHPNote.h"

@class MSVInputViewController;

@protocol MSVInputViewControllerDelegate <NSObject>

- (void)inputController:(MSVInputViewController *)controller
      didFinishWithText:(NSString *)text;
- (void)inputController:(MSVInputViewController *)controller
      didFinishWithRubiiNote:(NHPNote *)note;

@end

@interface MSVInputViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate > {
	UIImageView * imageView;
	UIButton * choosePhotoBtn;
	UIButton * takePhotoBtn;
}

@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, retain) IBOutlet UIButton * takePhotoBtn;
@property (strong) NHPNote *userNote;

-(IBAction) getPhoto:(id) sender;

@property (nonatomic, weak) id<MSVInputViewControllerDelegate> delegate;

@end
