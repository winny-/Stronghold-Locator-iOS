//
//  FirstViewController.h
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrongholdUtility.h"

@interface LocateStrongholdModelController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *location1TextField;
@property (weak, nonatomic) IBOutlet UITextField *location2TextField;

@property (weak, nonatomic) IBOutlet UILabel *strongholdLocationLabel;

@property (strong) SVector *result;

@property (weak, nonatomic) IBOutlet UIButton *sendCoordinatesToPasteboardButton;


- (IBAction)sendCoordinatesToPasteboard:(id)sender;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;
- (void)textFieldDidEndEditing:(UITextField *)theTextField;
@end
