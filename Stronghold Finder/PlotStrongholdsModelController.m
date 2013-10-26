//
//  SecondViewController.m
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import "PlotStrongholdsModelController.h"
#import "StrongholdUtility.h"

@interface PlotStrongholdsModelController ()

@end

@implementation PlotStrongholdsModelController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView = self.containerView.subviews[0];
//    self.knownCoordinatesLabel = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].detailTextLabel;
//    self.clockwiseCoordinatesLabel = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].detailTextLabel;
//    self.counterclockwiseCoordinatesLabel = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].detailTextLabel;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)plotStrongholds:(id)sender {
    [self textFieldShouldReturn:nil];
    self.inputIsValid = YES;
    self.xKnownNumber = [self parseNumberFromTextField:self.xTextField];
    self.zKnownNumber = [self parseNumberFromTextField:self.zTextField];
    
    if (!self.inputIsValid) {
        return;
    }
    
    
    
    UITableViewCell *knownCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]],
    *clockwiseCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]],
    *counterclockwiseCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    NSDictionary *result = [StrongholdUtility guessStrongholdLocations:[[SVector alloc] initWithX:self.xKnownNumber Z:self.zKnownNumber]];
    SVector *clockwise = result[@"clockwise"];
    SVector *counterclockwise = result[@"counterclockwise"];
    
    knownCell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@, %@", self.xKnownNumber, self.zKnownNumber];
    clockwiseCell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@, %@", clockwise.x, clockwise.z];
    counterclockwiseCell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@, %@", counterclockwise.x, counterclockwise.z];
    
    // empty detail label redraw requires this. https://discussions.apple.com/message/13028584#13028584
    [knownCell setNeedsLayout];
    [clockwiseCell setNeedsLayout];
    [counterclockwiseCell setNeedsLayout];
}

- (NSNumber *)parseNumberFromTextField:(UITextField *)theTextField {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    
    NSNumber *value = [f numberFromString:theTextField.text];
    
    if (value == nil) {
        self.inputIsValid = NO;
        theTextField.backgroundColor = [UIColor redColor];
    } else {
        theTextField.backgroundColor = [UIColor whiteColor];
    }
    
    return value;
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [self.xTextField resignFirstResponder];
    [self.zTextField resignFirstResponder];
    
    return YES;
}

@end
