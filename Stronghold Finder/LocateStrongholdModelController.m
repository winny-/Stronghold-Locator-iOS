//
//  FirstViewController.m
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import "LocateStrongholdModelController.h"
#import "StrongholdUtility.h"

@interface LocateStrongholdModelController ()

@end

@implementation LocateStrongholdModelController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
  
    if (theTextField == self.location1TextField) {
        [self.location2TextField becomeFirstResponder];
    } else {
        [self.location1TextField resignFirstResponder];
        [self.location2TextField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)theTextField {
    if (theTextField != self.location1TextField) {
        [self locate];
    }
}

#pragma mark - LocateStrongholdModelController

- (void)locate {
    Minecraft2DVector *location1, *location2;
    
    location1 = [Minecraft2DVector parseFromTextField:self.location1TextField];
    location2 = [Minecraft2DVector parseFromTextField:self.location2TextField];
    
    if (location1 == nil || location2 == nil) {
        NSLog(@"%s: invalid input (location1TextField = \"%@\" parsed \"%@\", location2TextField = \"%@\""
              "parsed \"%@\") returning.", __func__, self.location1TextField.text, location1,
              self.location2TextField.text, location2);
        return;
    }
    
    Minecraft2DVector *result;
    
    
    NSLog(@"location1=%@", location1);
    NSLog(@"location2=%@", location2);
    
    result = [StrongholdUtility locateStrongholdWithVector1:location1 Vector2:location2];
    
    self.result = [result copy];
    
    self.strongholdLocationLabel.text = [[NSString alloc] initWithFormat:@"%@, %@", self.result.x.stringValue, self.result.z.stringValue];
    self.strongholdLocationLabel.hidden = NO;
    
    self.sendCoordinatesToPasteboardButton.hidden = NO;
    [self.sendCoordinatesToPasteboardButton setEnabled:YES];
}

- (IBAction)sendCoordinatesToPasteboard:(id)sender {
    [self textFieldShouldReturn:nil];

    NSString *coordinatePair = [self.result description];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    [pasteboard setValue:coordinatePair forPasteboardType:@"public.utf8-plain-text"]; // see document titled: System-Declared Uniform Type Identifiers
    [self.sendCoordinatesToPasteboardButton setEnabled:NO];
}
@end
