//
//  SecondViewController.h
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrongholdUtility.h"

@interface PlotStrongholdsModelController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *knownTextField;

@property (strong) Minecraft2DCoordinate *knownLocation;
@property (strong) Minecraft2DCoordinate *clockwiseLocation;
@property (strong) Minecraft2DCoordinate *counterclockwiseLocation;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak) UITableView *tableView;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;
- (void)textFieldDidEndEditing:(UITextField *)theTextField;
@end
