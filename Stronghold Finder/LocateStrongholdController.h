//
//  FirstViewController.h
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocateStrongholdController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *x1TextField;
@property (weak, nonatomic) IBOutlet UITextField *z1TextField;
@property (weak, nonatomic) IBOutlet UITextField *f1TextField;

@property (weak, nonatomic) IBOutlet UITextField *x2TextField;
@property (weak, nonatomic) IBOutlet UITextField *z2TextField;
@property (weak, nonatomic) IBOutlet UITextField *f2TextField;

@property (weak, nonatomic) IBOutlet UILabel *xResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *zResultLabel;
@property (strong) NSNumber *xResultNumber;
@property (strong) NSNumber *zResultNumber;

@property BOOL inputIsValid;

@property (weak, nonatomic) IBOutlet UIButton *sendCoordinatesToPasteboardButton;


- (IBAction)locate:(id)sender;
- (IBAction)sendCoordinatesToPasteboard:(id)sender;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;

@end
