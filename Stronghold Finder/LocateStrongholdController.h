//
//  FirstViewController.h
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocateStrongholdController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *x1;
@property (weak, nonatomic) IBOutlet UITextField *z1;
@property (weak, nonatomic) IBOutlet UITextField *f1;

@property (weak, nonatomic) IBOutlet UITextField *x2;
@property (weak, nonatomic) IBOutlet UITextField *z2;
@property (weak, nonatomic) IBOutlet UITextField *f2;

@property (weak, nonatomic) IBOutlet UITextField *x;
@property (weak, nonatomic) IBOutlet UITextField *z;


- (IBAction)locate:(id)sender;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;

@end
