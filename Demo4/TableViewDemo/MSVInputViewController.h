//
//  MSVInputViewController.h
//  TableViewDemo
//
//  Created by Michael Vitrano on 4/15/14.
//  Copyright (c) 2014 Vitrano. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSVInputViewController;

@protocol MSVInputViewControllerDelegate <NSObject>

- (void)inputController:(MSVInputViewController *)controller
      didFinishWithText:(NSString *)text;

@end

@interface MSVInputViewController : UIViewController

@property (nonatomic, weak) id<MSVInputViewControllerDelegate> delegate;

@end
