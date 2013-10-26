//
//  SecondViewController.h
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlotStrongholdsModelController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *xTextField;
@property (weak, nonatomic) IBOutlet UITextField *zTextField;

@property (strong) NSNumber *xKnownNumber;
@property (strong) NSNumber *zKnownNumber;
@property BOOL inputIsValid;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak) UITableView *tableView;

//@property (weak, nonatomic) IBOutlet UITableViewCell *knownCoordinatesCell;
//@property (weak, nonatomic) IBOutlet UITableViewCell *clockwiseCoordinatesCell;
//@property (weak, nonatomic) IBOutlet UITableViewCell *counterclockwiseCoordinatesCell;
@property (weak, nonatomic) IBOutlet UILabel *knownCoordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *clockwiseCoordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *counterclockwiseCoordinatesLabel;

- (IBAction)plotStrongholds:(id)sender;

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField;

@end
