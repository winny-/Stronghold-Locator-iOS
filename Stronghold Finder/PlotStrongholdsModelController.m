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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)plotStrongholds {
    self.knownLocation = [Minecraft2DCoordinate parseFromTextField:self.knownTextField];
    
    if (self.knownLocation == nil) {
        NSLog(@"%s: invalid input, returning.", __func__);
        return;
    }
    
    
    
    UITableViewCell *knownCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]],
    *clockwiseCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]],
    *counterclockwiseCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    NSDictionary *result = [StrongholdUtility guessStrongholdLocations:self.knownLocation];
    self.clockwiseLocation = result[@"clockwise"];
    self.counterclockwiseLocation = result[@"counterclockwise"];
    
    knownCell.detailTextLabel.text = [self.knownLocation description];
    clockwiseCell.detailTextLabel.text = [self.clockwiseLocation description];
    counterclockwiseCell.detailTextLabel.text = [self.counterclockwiseLocation description];
    
    // empty detail label redraw requires this. https://discussions.apple.com/message/13028584#13028584
    [knownCell setNeedsLayout];
    [clockwiseCell setNeedsLayout];
    [counterclockwiseCell setNeedsLayout];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [self.knownTextField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)theTextField {
    [self plotStrongholds];
}
@end
