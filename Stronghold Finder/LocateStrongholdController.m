//
//  FirstViewController.m
//  Stronghold Finder
//
//  Created by Winston Weinert on 10/21/13.
//  Copyright (c) 2013 Winston Weinert. All rights reserved.
//

#import "LocateStrongholdController.h"
#import "StrongholdUtility.h"

@interface LocateStrongholdController ()

@end

@implementation LocateStrongholdController

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

- (IBAction)locate:(id)sender {
    self.inputIsValid = YES;
    [self textFieldShouldReturn:nil];
    
    NSNumber *x1Number = [self parseNumberFromTextField:self.x1TextField];
    NSNumber *z1Number = [self parseNumberFromTextField:self.z1TextField];
    NSNumber *f1Number = [self parseNumberFromTextField:self.f1TextField];
    
    NSNumber *x2Number = [self parseNumberFromTextField:self.x2TextField];
    NSNumber *z2Number = [self parseNumberFromTextField:self.z2TextField];
    NSNumber *f2Number = [self parseNumberFromTextField:self.f2TextField];
    
    if (!self.inputIsValid) {
        NSLog(@"Invalid input, returning.");
        return;
    }

    self.x1TextField.backgroundColor = [UIColor whiteColor];
    self.z1TextField.backgroundColor = [UIColor whiteColor];
    self.f1TextField.backgroundColor = [UIColor whiteColor];

    self.x2TextField.backgroundColor = [UIColor whiteColor];
    self.z2TextField.backgroundColor = [UIColor whiteColor];
    self.f2TextField.backgroundColor = [UIColor whiteColor];

    
    SVector *result;
    SVector *location1, *location2;
    
    location1 = [[SVector alloc] initWithX:x1Number Z:z1Number F:f1Number];
    location2 = [[SVector alloc] initWithX:x2Number Z:z2Number F:f2Number];
    NSLog(@"location1=%@", location1);
    NSLog(@"location2=%@", location2);
    
    result = [StrongholdUtility locateStrongholdWithVector1:location1 Vector2:location2];
    
    self.xResultNumber = [result.x copy];
    self.zResultNumber = [result.z copy];
    
    self.xResultLabel.text = result.x.stringValue;
    self.zResultLabel.text = result.z.stringValue;
    
    self.xResultLabel.hidden = NO;
    self.zResultLabel.hidden = NO;
    self.sendCoordinatesToPasteboardButton.hidden = NO;
}

- (NSNumber *)parseNumberFromTextField:(UITextField *)theTextField {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    
    NSNumber *value = [f numberFromString:theTextField.text];
    
    if (value == nil) {
        self.inputIsValid = NO;
        theTextField.backgroundColor = [UIColor redColor];
    }
    
    return value;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [self.x1TextField resignFirstResponder];
    [self.z1TextField resignFirstResponder];
    [self.f1TextField resignFirstResponder];
    
    [self.x2TextField resignFirstResponder];
    [self.z2TextField resignFirstResponder];
    [self.f2TextField resignFirstResponder];
    
    return YES;
}

- (IBAction)sendCoordinatesToPasteboard:(id)sender {
    [self textFieldShouldReturn:nil];

    NSString *coordinatePair = [[NSString alloc] initWithFormat:@"%@, %@", self.xResultNumber, self.zResultNumber];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    [pasteboard setValue:coordinatePair forPasteboardType:@"public.utf8-plain-text"]; // see document titled: System-Declared Uniform Type Identifiers
}
@end